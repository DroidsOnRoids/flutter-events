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
import 'package:events/pages/event_details/event_details_page.dart';
import 'package:events/pages/events_list/widgets/cover_image.dart';
import 'package:events/pages/events_list/widgets/event_card.dart';
import 'package:events/widgets/app_button.dart';
import 'package:events/widgets/event_description.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/network_error.dart';
import 'package:events/widgets/network_loader.dart';
import 'package:events/widgets/overscroll.dart';
import 'package:events/widgets/tap_detector.dart';
import 'package:events/widgets/titled_container.dart';

import 'blocs/events_list_bloc.dart';
import 'blocs/events_list_bloc_states.dart';

class EventsListPage extends StatefulWidget {
  final EventsListBlocType _bloc;

  EventsListPage({@required EventsListBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  EventsListPage.build() : this(bloc: EventsListBlocType.build());

  @override
  _EventsListPageState createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  EventsListBlocType get _bloc => widget._bloc;

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
        navigationBar: NavigationBar(title: 'EVENTS'),
        child: StreamBuilder(
            stream: _bloc.stream,
            builder: (context, AsyncSnapshot<EventsListBlocState> snapshot) {
              final data = snapshot.data;

              if (data is EventsListBlocContentState) {
                return _buildContent(context, data);
              } else if (data is EventsListBlocErrorState) {
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

  Widget _buildContent(BuildContext context, EventsListBlocContentState state) {
    return Overscroll(
      child: ListView(
        children: <Widget>[
          TapDetector(
              childBuilder: (bool isPressed) => AnimatedOpacity(
                  opacity: isPressed ? 0.75 : 1.0,
                  duration: Duration(milliseconds: 100),
                  child: CoverImage(imageUrl: state.coverImageUrl)),
              onTap: () {
                _pushEventDetails(id: state.eventId);
              }),
          EventDescription(
            title: state.title,
            subtitle: state.subtitle,
            placeName: state.placeName,
            placeStreet: state.placeStreet,
            date: state.date,
            time: state.time,
            onTitleTap: () {
              _pushEventDetails(id: state.eventId);
            },
            buttons: [
              AppButton(text: 'ATTEND', style: AppButtonStyle.filled),
              AppButton(text: 'REMIND ME', style: AppButtonStyle.bordered)
            ],
          ),
          _buildCardsList(
              states: state.cardStates,
              onTap: (eventId) {
                _pushEventDetails(id: eventId);
              })
        ],
      ),
    );
  }

  Widget _buildCardsList(
      {List<EventsListBlocCardContentState> states, void onTap(int eventId)}) {
    return TitledContainer(
        title: 'PREVIOUS LET SWIFT MEET-UPS',
        child: Container(
            height: 152.0,
            child: ListView.builder(
                itemCount: states.length,
                itemBuilder: (context, index) {
                  final cardState = states[index];

                  return TapDetector(
                      childBuilder: (bool isPressed) => AnimatedOpacity(
                          opacity: isPressed ? 0.75 : 1.0,
                          duration: Duration(milliseconds: 100),
                          child: EventCard(
                            image: cardState.thumbnailImageUrl != null
                                ? NetworkImage(cardState.thumbnailImageUrl)
                                : AssetImage('images/event_placeholder.png'),
                            title: cardState.title,
                            date: cardState.date,
                          )),
                      onTap: () {
                        onTap(cardState.eventId);
                      });
                },
                padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                scrollDirection: Axis.horizontal)));
  }

  void _pushEventDetails({int id}) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => EventDetailsPage.build(eventId: id)));
  }
}
