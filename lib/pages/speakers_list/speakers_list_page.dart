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

import 'package:events/pages/speaker_details/speaker_details_page.dart';
import 'package:events/pages/speakers_list/widgets/collapsable_container.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/network_error.dart';
import 'package:events/widgets/network_loader.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:events/widgets/tap_detector.dart';
import 'package:events/widgets/titled_container.dart';
import 'package:flutter/cupertino.dart';

import 'blocs/speakers_list_bloc.dart';
import 'blocs/speakers_list_bloc_states.dart';

class SpeakersListPage extends StatefulWidget {
  final SpeakersListBlocType _bloc;

  SpeakersListPage({@required SpeakersListBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  SpeakersListPage.build() : this(bloc: SpeakersListBlocType.build());

  @override
  _SpeakersListPageState createState() => _SpeakersListPageState();
}

class _SpeakersListPageState extends State<SpeakersListPage> {
  SpeakersListBlocType get _bloc => widget._bloc;

  final _focus = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focus.addListener(_onFocusChange);
    _bloc.fetch();
  }

  @override
  void dispose() {
    _bloc.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    final isFocused = _focus.hasFocus;
    setState(() {
      _isFocused = isFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'SPEAKERS'),
        child: StreamBuilder(
            stream: _bloc.stream,
            builder: (context, AsyncSnapshot<SpeakersListBlocState> snapshot) {
              final data = snapshot.data;

              if (data is SpeakersListBlocContentState) {
                return _buildContent(context, data);
              } else if (data is SpeakersListBlocErrorState) {
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
      BuildContext context, SpeakersListBlocContentState data) {
    return ListView(
      children: <Widget>[
        Container(
            color: AppColors.of(context).whitishGray,
            padding: EdgeInsets.all(8.0),
            child: CupertinoTextField(
              focusNode: _focus,
              onChanged: (text) {
                _bloc.searchSink.add(text);
              },
              padding: EdgeInsets.all(8.0),
              placeholder: 'Search speakers',
              style: TextStyle(
                  color: AppColors.of(context).bluishGray,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400),
              decoration: BoxDecoration(
                color: AppColors.of(context).white,
                borderRadius: BorderRadius.circular(5.0),
              ),
            )),
        CollapsableContainer(
            child: _buildLastSpeakers(context, data), isCollapsed: _isFocused),
        for (final speaker in data.speakersList)
          TapDetector(
            childBuilder: (bool isPressed) => AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                    color: isPressed
                        ? AppColors.of(context).lightGray.withAlpha(128)
                        : null),
                child: _buildSpeakerCard(
                    speaker, speaker != data.speakersList.last)),
            onTap: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) =>
                      SpeakerDetailsPage.build(speakerId: speaker.speakerId)));
            },
          ),
      ],
    );
  }

  Widget _buildLastSpeakers(
      BuildContext context, SpeakersListBlocContentState data) {
    return TitledContainer(
        title: 'LATEST LET SWIFT SPEAKERS',
        child: Container(
            height: 188.0,
            child: ListView.builder(
                itemCount: data.recentSpeakers.length,
                itemBuilder: (context, index) {
                  final recentSpeaker = data.recentSpeakers[index];

                  return TapDetector(
                    childBuilder: (bool isPressed) => AnimatedOpacity(
                        opacity: isPressed ? 0.75 : 1.0,
                        duration: Duration(milliseconds: 100),
                        child: _buildLastSpeakerCard(recentSpeaker)),
                    onTap: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => SpeakerDetailsPage.build(
                              speakerId: recentSpeaker.speakerId)));
                    },
                  );
                },
                padding: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
                scrollDirection: Axis.horizontal)));
  }

  Widget _buildLastSpeakerCard(SpeakersListBlocCardContentState data) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: AppColors.of(context).black.withAlpha(25),
            blurRadius: 10.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 2.0))
      ]),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(fit: StackFit.passthrough, children: [
            PlaceholderImage(
                image: NetworkImage(data.thumbnailImageUrl),
                placeholder: AssetImage('images/event_placeholder.png'),
                // TODO: Replace placeholder
                fit: BoxFit.cover,
                width: 150),
            Positioned.fill(
                child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color.fromARGB(0, 112, 112, 112),
                          AppColors.of(context).black
                        ])),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Align(
                          child: Image.asset('images/indicator.png'),
                          alignment: Alignment.centerRight,
                        ),
                        Text(data.name,
                            style: TextStyle(
                                color: AppColors.of(context).white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.87))
                      ],
                    )))
          ])),
    );
  }

  Widget _buildSpeakerCard(
      SpeakersListBlocCardContentState data, bool hasBorder) {
    return IntrinsicHeight(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: ClipOval(
              child: PlaceholderImage(
                  image: NetworkImage(data.thumbnailImageUrl),
                  placeholder: AssetImage('images/event_placeholder.png'),
                  // TODO: Replace placeholder
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                border: hasBorder
                    ? Border(
                        bottom: BorderSide(
                            color: AppColors.of(context).lightGray, width: 0.0))
                    : null),
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(data.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            letterSpacing: 1.0,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    Text(data.job,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.of(context).darkGray,
                            letterSpacing: 1.0,
                            fontSize: 13,
                            fontWeight: FontWeight.w400))
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Image.asset('images/indicator.png'))
            ]),
          )),
        ]));
  }
}
