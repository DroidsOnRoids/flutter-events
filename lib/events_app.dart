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

import 'package:events/pages/contact/contact_page.dart';
import 'package:events/pages/events_list/events_list_page.dart';
import 'package:events/pages/onboarding/onboarding_page.dart';
import 'package:events/pages/speakers_list/speakers_list_page.dart';
import 'package:events/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

class EventsApp extends StatefulWidget {
  @override
  _EventsAppState createState() => _EventsAppState();
}

class _EventsAppState extends State<EventsApp> {
  bool onboardingFinished = false;

  @override
  Widget build(BuildContext context) {
    return AppColors(child: Builder(builder: _buildApp));
  }

  Widget _buildApp(BuildContext context) {
    final tabScaffold = CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          backgroundColor: AppColors.of(context).white,
          border: Border(
            top: BorderSide(
              color: AppColors.of(context).lightGray,
              width: 0.0,
              style: BorderStyle.solid,
            ),
          ),
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('images/events.png'),
                activeIcon: Image.asset('images/events_active.png')),
            BottomNavigationBarItem(
                icon: Image.asset('images/speakers.png'),
                activeIcon: Image.asset('images/speakers_active.png')),
            BottomNavigationBarItem(
                icon: Image.asset('images/contact.png'),
                activeIcon: Image.asset('images/contact_active.png'))
          ]),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
                builder: (context) => EventsListPage.build());
          case 1:
            return CupertinoTabView(
                builder: (context) => SpeakersListPage.build());
          case 2:
            return CupertinoTabView(builder: (context) => ContactPage.build());
          default:
            return null;
        }
      },
    );

    return CupertinoApp(
      home: onboardingFinished
          ? tabScaffold
          : OnboardingPage(onContinue: () {
              setState(() {
                onboardingFinished = true;
              });
            }),
      theme: CupertinoThemeData(
        primaryColor: AppColors.of(context).primary,
      ),
    );
  }
}
