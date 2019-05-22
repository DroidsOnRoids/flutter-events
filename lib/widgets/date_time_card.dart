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

import 'package:flutter/widgets.dart';
import 'package:events/utils/app_colors.dart';

class DateTimeCard extends StatelessWidget {
  DateTimeCard({@required this.date, @required this.time})
      : assert(date != null),
        assert(time != null);

  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: AppColors.of(context).lightGray))),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 8.0),
                      child: Image.asset('images/calendar.png'),
                    ),
                    Text(date,
                        style: TextStyle(
                            color: AppColors.of(context).darkGray,
                            letterSpacing: 0.93,
                            fontSize: 13,
                            fontWeight: FontWeight.w400))
                  ]))),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(color: AppColors.of(context).lightGray))),
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                child: Image.asset('images/clock.png'),
              ),
              Text(time,
                  style: TextStyle(
                      color: AppColors.of(context).darkGray,
                      letterSpacing: 0.93,
                      fontSize: 13,
                      fontWeight: FontWeight.w400))
            ]),
          ))
        ],
      ),
    );
  }
}
