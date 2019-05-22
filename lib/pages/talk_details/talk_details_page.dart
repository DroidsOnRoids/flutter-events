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

import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:events/widgets/tap_detector.dart';
import 'package:flutter/cupertino.dart';

import 'blocs/talk_details_bloc.dart';
import 'blocs/talk_details_bloc_states.dart';

class TalkDetailsPage extends StatefulWidget {
  final TalkDetailsBlocType _bloc;

  TalkDetailsPage({@required TalkDetailsBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  TalkDetailsPage.build({TalkDetailsBlocState state})
      : this(bloc: TalkDetailsBlocType.build(state: state));

  @override
  _TalkDetailsPageState createState() => _TalkDetailsPageState();
}

class _TalkDetailsPageState extends State<TalkDetailsPage> {
  TalkDetailsBlocType get _bloc => widget._bloc;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'LECTURE DETAILS', hasBorder: true),
        child: ListView(children: <Widget>[
          _buildSpeakerCard(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/calendar.png',
                      color: AppColors.of(context).darkerGray),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(_bloc.state.date,
                      style: TextStyle(
                          color: AppColors.of(context).darkGray,
                          letterSpacing: 0.93,
                          fontSize: 13,
                          fontWeight: FontWeight.w400)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('images/clock.png',
                      color: AppColors.of(context).darkerGray),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(_bloc.state.time,
                      style: TextStyle(
                          color: AppColors.of(context).darkGray,
                          letterSpacing: 0.93,
                          fontSize: 13,
                          fontWeight: FontWeight.w400)),
                ),
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
                    child: Text(_bloc.state.talkTitle,
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600)),
                  ),
                  Text(_bloc.state.talkDescription,
                      style: TextStyle(
                          color: AppColors.of(context).darkGray,
                          fontSize: 13.0,
                          letterSpacing: 0.87,
                          fontWeight: FontWeight.w500,
                          height: 1.38))
                ],
              )),
        ]));
  }

  Widget _buildSpeakerCard() {
    final content = Row(
      children: <Widget>[
        ClipOval(
            child: PlaceholderImage(
                image: NetworkImage(_bloc.state.speakerImageUrl),
                placeholder: AssetImage('images/event_placeholder.png'),
                // TODO: Replace placeholder
                width: 40,
                height: 40,
                fit: BoxFit.cover)),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_bloc.state.speakerName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                Text(_bloc.state.speakerJob,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.of(context).darkGray,
                        letterSpacing: 1.0,
                        fontSize: 13,
                        fontWeight: FontWeight.w400))
              ],
            ),
          ),
        ),
        Image.asset('images/indicator.png')
      ],
    );

    return ClipRect(
        child: TapDetector(
            childBuilder: (bool isPressed) => AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: isPressed
                        ? AppColors.of(context).lightGray.withAlpha(128)
                        : null,
                    border: NavigationBar.DEFAULT_BORDER),
                padding: EdgeInsets.all(16.0),
                child: content),
            onTap: () {}));
  }
}
