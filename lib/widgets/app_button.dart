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
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/tap_detector.dart';

enum AppButtonStyle { filled, bordered }

class AppButton extends StatelessWidget {
  AppButton(
      {@required this.text,
      @required this.style,
      this.onTap,
      this.height = 38.0})
      : assert(text != null),
        assert(style != null);

  final String text;
  final AppButtonStyle style;
  final GestureTapCallback onTap;
  final double height;

  Color _backgroundColor(BuildContext context) {
    switch (style) {
      case AppButtonStyle.bordered:
        return AppColors.of(context).white;
      case AppButtonStyle.filled:
        return AppColors.of(context).primary;
      default:
        return null;
    }
  }

  Color _textColor(BuildContext context) {
    switch (style) {
      case AppButtonStyle.bordered:
        return AppColors.of(context).primary;
      case AppButtonStyle.filled:
        return AppColors.of(context).white;
      default:
        return null;
    }
  }

  Color _shadowColor(BuildContext context) {
    switch (style) {
      case AppButtonStyle.filled:
        return AppColors.of(context).primary;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonBody = Container(
        height: height,
        decoration: BoxDecoration(
            color: _backgroundColor(context),
            border: Border.all(color: AppColors.of(context).primary),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: _shadowColor(context) == null
                ? []
                : [
                    BoxShadow(
                        color: _shadowColor(context),
                        blurRadius: 16.0,
                        spreadRadius: -8.0,
                        offset: Offset(0.0, 8.0))
                  ]),
        child: Center(
            child: Text(text,
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _textColor(context)))));

    return TapDetector(
        childBuilder: (bool isPressed) {
          return AnimatedOpacity(
              opacity: isPressed ? 0.5 : 1.0,
              duration: Duration(milliseconds: 100),
              child: buttonBody);
        },
        onTap: onTap);
  }
}
