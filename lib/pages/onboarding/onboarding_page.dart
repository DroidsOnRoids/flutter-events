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
import 'package:events/pages/onboarding/widgets/onboarding_circle.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/dots_indicator.dart';

class OnboardingPage extends StatefulWidget {
  final GestureTapCallback onContinue;

  OnboardingPage({this.onContinue});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentPage = 0;
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'let Swift',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17, letterSpacing: 0.35, fontFamily: 'Menlo'),
            ),
            Expanded(
                child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 32),
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Column(children: <Widget>[
                      OnboardingCircle(angle: _angle, offset: Offset(0.0, 0.0)),
                      DotsIndicator(
                        numberOfDots: 3,
                        highlightedDot: _currentPage,
                        dotsColor: AppColors.of(context).lightGray,
                      ),
                    ]),
                  ),
                ),
                NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      final pageOffset = notification.metrics.pixels /
                          notification.metrics.maxScrollExtent;
                      final newAngle = pageOffset * 3.14;

                      setState(() {
                        _angle = newAngle;
                      });
                    },
                    child: PageView(
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        _buildPage(context),
                        _buildPage(context),
                        _buildPage(context)
                      ],
                    ))
              ],
            )),
            CupertinoButton(
              child: Text('CONTINUE',
                  style: TextStyle(
                      fontSize: 13.0,
                      letterSpacing: 0.93,
                      fontWeight: FontWeight.w600)),
              onPressed: widget.onContinue,
              pressedOpacity: 0.5,
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[_buildPageText(context)],
    );
  }

  Widget _buildPageText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: <Widget>[
          Text(
            'Meet-ups every month',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 17.0,
                letterSpacing: 1.0,
                color: AppColors.of(context).primary),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 64.0),
            child: Text(
                'let Swift is a monthly iOS developers’ meeting taking place in Wrocław',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.0,
                    letterSpacing: 0.88,
                    color: AppColors.of(context).darkGray)),
          )
        ],
      ),
    );
  }
}
