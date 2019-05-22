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

class NavigationBar extends CupertinoNavigationBar {
  static const Border DEFAULT_BORDER = Border(
    bottom: BorderSide(
      color: Color(0x4C000000),
      width: 0.0,
      style: BorderStyle.solid,
    ),
  );

  NavigationBar({title, hasBorder})
      : super(
            backgroundColor: Color(0xfeffffff),
            border: hasBorder == true ? DEFAULT_BORDER : null,
            middle: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0,
                  letterSpacing: 1.0),
            ));
}
