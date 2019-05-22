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
import 'package:flutter/cupertino.dart';

import 'app_button.dart';

class NetworkError extends StatelessWidget {
  NetworkError({@required this.errorText, this.onTryAgainTap})
      : assert(errorText != null);

  final String errorText;
  final GestureTapCallback onTryAgainTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(errorText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.of(context).darkGray,
                letterSpacing: 0.93,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              )),
          Container(height: 16),
          AppButton(
            style: AppButtonStyle.filled,
            text: 'Try again',
            onTap: onTryAgainTap,
          )
        ],
      ),
    );
  }
}
