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

class DotsIndicator extends StatelessWidget {
  final int numberOfDots;
  final int highlightedDot;
  final Color dotsColor;
  final bool hasShadow;

  DotsIndicator(
      {@required this.numberOfDots,
      this.highlightedDot,
      this.dotsColor,
      this.hasShadow})
      : assert(numberOfDots != null);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(numberOfDots,
            (index) => _buildDot(context, index == highlightedDot)));
  }

  Widget _buildDot(BuildContext context, bool isHighlighted) {
    return Container(
      margin: EdgeInsets.all(7.0),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
          boxShadow: [
            if (hasShadow == true)
              BoxShadow(
                  color: AppColors.of(context).black.withAlpha(128),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0))
          ],
          borderRadius: BorderRadius.circular(3.0),
          color: isHighlighted
              ? AppColors.of(context).primary
              : dotsColor ?? AppColors.of(context).white),
    );
  }
}
