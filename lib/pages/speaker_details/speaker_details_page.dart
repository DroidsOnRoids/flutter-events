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

import 'package:events/pages/talk_details/talk_details_page.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/network_error.dart';
import 'package:events/widgets/network_loader.dart';
import 'package:events/widgets/overscroll.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:events/widgets/talk_card.dart';
import 'package:events/widgets/titled_container.dart';
import 'package:flutter/cupertino.dart';

import 'blocs/speaker_details_bloc.dart';
import 'blocs/speaker_details_bloc_states.dart';

class SpeakerDetailsPage extends StatefulWidget {
  final SpeakerDetailsBlocType _bloc;

  SpeakerDetailsPage({@required SpeakerDetailsBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  SpeakerDetailsPage.build({@required int speakerId})
      : this(bloc: SpeakerDetailsBlocType.build(speakerId: speakerId));

  @override
  _SpeakerDetailsPageState createState() => _SpeakerDetailsPageState();
}

class _SpeakerDetailsPageState extends State<SpeakerDetailsPage> {
  SpeakerDetailsBlocType get _bloc => widget._bloc;

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
        navigationBar: NavigationBar(title: 'SPEAKER DETAILS', hasBorder: true),
        child: StreamBuilder(
            stream: _bloc.stream,
            builder:
                (context, AsyncSnapshot<SpeakerDetailsBlocState> snapshot) {
              final data = snapshot.data;

              if (data is SpeakerDetailsBlocContentState) {
                return _buildContent(data);
              } else if (data is SpeakerDetailsBlocErrorState) {
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

  Widget _buildContent(SpeakerDetailsBlocContentState state) {
    final shouldShowCards = state.cards.isNotEmpty;
    final content = ListView(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 32.0, bottom: 16.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: AppColors.of(context).lightGray, width: 0.0))),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: AppColors.of(context).black.withAlpha(75),
                      blurRadius: 10.0,
                      spreadRadius: -8,
                      offset: Offset(0.0, 12.0))
                ]),
                child: ClipOval(
                    child: PlaceholderImage(
                        image: NetworkImage(state.avatarUrl),
                        placeholder: AssetImage('images/event_placeholder.png'),  // TODO: Replace placeholder
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(state.name,
                    style: TextStyle(
                        color: AppColors.of(context).primary,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5)),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text(state.job,
                      style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5))),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset('images/github.png'),
                  Image.asset('images/www.png'),
                  Image.asset('images/twitter.png'),
                  Image.asset('images/email.png'),
                ],
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Text('About ' + state.name,
                      style: TextStyle(
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w600)),
                ),
                Text(state.bio,
                    style: TextStyle(
                        color: AppColors.of(context).darkGray,
                        fontSize: 13.0,
                        letterSpacing: 0.87,
                        fontWeight: FontWeight.w500,
                        height: 1.38))
              ],
            )),
        if (shouldShowCards)
          TitledContainer(
            title: 'PARTICIPED IN',
            child: Container(
                height: 300.0,
                child: PageView.builder(
                    itemCount: state.cards.length,
                    itemBuilder: (context, index) {
                      final cardState = state.cards[index];

                      return Padding(
                          padding: EdgeInsets.only(bottom: 4.0),
                          child: TalkCard(
                              speakerImageUrl: cardState.speakerImageUrl,
                              speakerName: cardState.speakerName,
                              speakerJob: cardState.speakerJob,
                              talkTitle: cardState.talkTitle,
                              talkDescription: cardState.talkDescription,
                              onReadMoreTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            TalkDetailsPage.build()));
                              }));
                    },
                    controller: PageController(viewportFraction: 0.95))),
          )
      ],
    );

    return shouldShowCards ? Overscroll(child: content) : content;
  }
}
