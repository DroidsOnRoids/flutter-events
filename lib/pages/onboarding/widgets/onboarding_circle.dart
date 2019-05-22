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

class OnboardingCircle extends StatelessWidget {
  final double angle;
  final Offset offset;

  OnboardingCircle({@required this.angle, @required this.offset})
      : assert(angle != null),
        assert(offset != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.translate(
            offset: offset * 1.0,
            child: Image.asset('images/onboarding_shapes.png')),
        Transform.translate(
            offset: offset * 0.75,
            child: Transform.rotate(
                angle: angle,
                child: Image.asset('images/onboarding_outer_circle.png'))),
        Transform.translate(
            offset: offset * 0.5,
            child: Transform.rotate(
                angle: angle / 2.0,
                child: Image.asset('images/onboarding_inner_circle.png'))),
        Transform.translate(
            offset: offset * 0.25,
            child: Image.asset('images/onboarding_center_circle.png')),
        Transform.translate(
            offset: offset * 0.0,
            child: Image.asset('images/onboarding_calendar.png')),
      ],
    );
  }
}
