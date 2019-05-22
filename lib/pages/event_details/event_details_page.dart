//
//  Copyright 2019 Droids On Roids
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import 'package:flutter/cupertino.dart';
import 'package:events/pages/event_details/widgets/image_slider.dart';
import 'package:events/pages/photos_list/photos_list_page.dart';
import 'package:events/pages/talk_details/talk_details_page.dart';
import 'package:events/widgets/app_button.dart';
import 'package:events/widgets/event_description.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/network_error.dart';
import 'package:events/widgets/network_loader.dart';
import 'package:events/widgets/overscroll.dart';
import 'package:events/widgets/talk_card.dart';
import 'package:events/widgets/titled_container.dart';

import 'blocs/event_details_bloc.dart';
import 'blocs/event_details_bloc_states.dart';

class EventDetailsPage extends StatefulWidget {
  final EventDetailsBlocType _bloc;

  EventDetailsPage({@required EventDetailsBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  EventDetailsPage.build({@required int eventId})
      : this(bloc: EventDetailsBlocType.build(eventId: eventId));

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  EventDetailsBlocType get _bloc => widget._bloc;

  @override
  void initState() {
    super.initState();

    _bloc.fetch();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'EVENT DETAILS'),
        child: StreamBuilder(
            stream: _bloc.stream,
            builder: (context, AsyncSnapshot<EventDetailsBlocState> snapshot) {
              final data = snapshot.data;

              if (data is EventDetailsBlocContentState) {
                return _buildContent(context, data);
              } else if (data is EventDetailsBlocErrorState) {
                return NetworkError(
                    errorText: data.error,
                    onTryAgainTap: () {
                      _bloc.onTryAgainTap();
                    });
              } else {
                return NetworkLoader();
              }
            }));
  }

  Widget _buildContent(
      BuildContext context, EventDetailsBlocContentState state) {
    final shouldShowSpeakers = state.cardStates.isNotEmpty;
    final content = ListView(
      children: <Widget>[
        ImageSlider(imageUrls: state.coverImageUrls),
        EventDescription(
            title: state.title,
            subtitle: state.subtitle,
            placeName: state.placeName,
            placeStreet: state.placeStreet,
            date: state.date,
            time: state.time,
            buttons: [
              AppButton(
                  text: 'SEE PHOTOS',
                  style: AppButtonStyle.filled,
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                PhotosListPage.build(photos: state.photos)));
                  })
            ]),
        if (shouldShowSpeakers) _buildSpeakersCards(state.cardStates)
      ],
    );

    return shouldShowSpeakers ? Overscroll(child: content) : content;
  }

  Widget _buildSpeakersCards(List<EventDetailsBlocCardContentState> states) {
    return TitledContainer(
        title: 'SPEAKERS',
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
          child: Column(
              children: states
                  .map((state) => IntrinsicHeight(
                      child: TalkCard(
                          speakerImageUrl: state.speakerImageUrl,
                          speakerName: state.speakerName,
                          speakerJob: state.speakerJob,
                          talkTitle: state.talkTitle,
                          talkDescription: state.talkDescription,
                          onReadMoreTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        TalkDetailsPage.build()));
                          })))
                  .toList()),
        ));
  }
}
