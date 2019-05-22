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

import 'app_button.dart';
import 'date_time_card.dart';

class EventDescription extends StatelessWidget {
  EventDescription(
      {@required this.title,
      @required this.subtitle,
      @required this.placeName,
      @required this.placeStreet,
      @required this.date,
      @required this.time,
      this.onTitleTap,
      this.buttons})
      : assert(title != null),
        assert(subtitle != null),
        assert(placeName != null),
        assert(placeStreet != null),
        assert(date != null),
        assert(time != null);

  final String title;
  final String subtitle;
  final String placeName;
  final String placeStreet;
  final String date;
  final String time;
  final GestureTapCallback onTitleTap;
  final List<AppButton> buttons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (buttons != null) _buildButtonsRow(),
        _buildSummaryCard(context),
        _buildLocationCard(context),
        DateTimeCard(date: date, time: time),
      ],
    );
  }

  Widget _buildButtonsRow() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
          children: buttons
              .map((button) => Expanded(
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: button)))
              .toList()),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
          border:
              Border(top: BorderSide(color: AppColors.of(context).lightGray))),
      child: _buildTappableCard(
          context: context,
          middle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      color: AppColors.of(context).primary,
                      letterSpacing: 1.15,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                Text(subtitle,
                    style: TextStyle(
                        color: AppColors.of(context).darkGray,
                        letterSpacing: 1.15,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ]),
          onTap: onTitleTap),
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    return _buildTappableCard(
        context: context,
        left: Container(
          margin: EdgeInsets.only(right: 12.0),
          padding: EdgeInsets.only(top: 2.0),
          child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset('images/marker.png')),
        ),
        middle: RichText(
            text: TextSpan(
          style: TextStyle(
            color: AppColors.of(context).darkGray,
            letterSpacing: 0.93,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          children: <TextSpan>[
            new TextSpan(
                text: placeName,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.of(context).black)),
            new TextSpan(text: ' — ' + placeStreet),
          ],
        )));
  }

  Widget _buildTappableCard(
      {BuildContext context,
      Widget left,
      Widget middle,
      GestureTapCallback onTap}) {
    return TapDetector(
        childBuilder: (bool isPressed) => AnimatedContainer(
            duration: Duration(milliseconds: 100),
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
                color: (onTap != null && isPressed)
                    ? AppColors.of(context).lightGray.withAlpha(128)
                    : null,
                border: Border(
                    bottom:
                        BorderSide(color: AppColors.of(context).lightGray))),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (left != null) left,
                  Expanded(child: middle),
                  if (onTap != null)
                    Container(
                      margin: EdgeInsets.only(left: 12.0),
                      child: Center(child: Image.asset('images/indicator.png')),
                    ),
                ],
              ),
            )),
        onTap: onTap);
  }
}
