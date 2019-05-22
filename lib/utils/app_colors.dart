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

import 'dart:ui';

import 'package:flutter/widgets.dart';

class AppColors extends InheritedWidget {
  AppColors({Widget child}) : super(child: child, key: null);

  final primary = const Color(0xffffc037);
  final white = const Color(0xffffffff);
  final whitishGray = const Color(0xffdee5ef);
  final lightGray = const Color(0xffd7e0eb);
  final darkGray = const Color(0xff989ea6);
  final darkerGray = const Color(0xff6e7175);
  final bluishGray = const Color(0xff848f9e);
  final black = const Color(0xff000000);

  static AppColors of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(AppColors);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
