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
import 'package:flutter/cupertino.dart';

class TalkDetailsPage extends StatefulWidget {
  TalkDetailsPage();

  TalkDetailsPage.build() : this();

  @override
  _TalkDetailsPageState createState() => _TalkDetailsPageState();
}

class _TalkDetailsPageState extends State<TalkDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'LECTURE DETAILS', hasBorder: true),
        child: ListView(children: <Widget>[
          ClipRect(
            child: Container(
                decoration: BoxDecoration(border: NavigationBar.DEFAULT_BORDER),
                padding: EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    ClipOval(
                        child: PlaceholderImage(
                            image: NetworkImage(
                                'https://avatars0.githubusercontent.com/u/4096232?s=460&v=4'),
                            placeholder: AssetImage('images/event_placeholder.png'),  // TODO: Replace placeholder
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
                            Text('Oktawian Chojnacki',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                            Text('iOS Developer',
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
                )),
          ),
          Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: Text('Super simple: Renderable!',
                        style: TextStyle(
                            fontSize: 15.0,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w600)),
                  ),
                  Text(
                      '''Testerzy mnie nienawidzą. Posłuchaj o tym jak być mniej beznadziejnym, stosując ten jeden dziwny trick… 

Architektura kodu ma za zadanie ulżyć umysłowi, aby mógł się skupić na złożonych problemach.

Przedstawię Renderable - pierwszy komponent konceptu architektury, którą nazywam Super Simple.''',
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
}
