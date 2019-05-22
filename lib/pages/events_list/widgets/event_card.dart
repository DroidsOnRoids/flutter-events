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

class EventCard extends StatelessWidget {
  EventCard({@required this.image, @required this.title, @required this.date})
      : assert(image != null),
        assert(title != null),
        assert(date != null);

  final ImageProvider image;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.of(context).black.withAlpha(25),
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, 5.0))
        ]),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: IntrinsicWidth(
                child: Column(children: <Widget>[
              Expanded(
                  child: FadeInImage(
                      fadeInDuration: Duration.zero,
                      fadeOutDuration: Duration.zero,
                      image: image,
                      placeholder: AssetImage('images/event_placeholder.png'),
                      fit: BoxFit.cover,
                      width: 150)),
              Container(
                color: AppColors.of(context).white,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(title,
                              style: TextStyle(
                                  color: AppColors.of(context).primary,
                                  letterSpacing: 1.0,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600)),
                          Text(date,
                              style: TextStyle(
                                  color: AppColors.of(context).darkGray,
                                  letterSpacing: 0.87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                    Container(child: Image.asset('images/indicator.png'))
                  ],
                ),
              )
            ]))));
  }
}
