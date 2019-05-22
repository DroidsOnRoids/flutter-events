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
import 'package:events/widgets/placeholder_image.dart';
import 'package:flutter/cupertino.dart';

class TalkCard extends StatelessWidget {
  TalkCard(
      {@required this.speakerImageUrl,
      @required this.speakerName,
      @required this.speakerJob,
      @required this.talkTitle,
      @required this.talkDescription,
      this.onReadMoreTap})
      : assert(speakerImageUrl != null),
        assert(speakerName != null),
        assert(speakerJob != null),
        assert(talkTitle != null),
        assert(talkDescription != null);

  final String speakerImageUrl;
  final String speakerName;
  final String speakerJob;
  final String talkTitle;
  final String talkDescription;
  final GestureTapCallback onReadMoreTap;

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
            child: Container(
              color: AppColors.of(context).white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: AppColors.of(context).lightGray,
                                width: 0.0))),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        ClipOval(
                            child: PlaceholderImage(
                                image: NetworkImage(speakerImageUrl),
                                placeholder:
                                    AssetImage('images/event_placeholder.png'),
                                // TODO: Replace placeholder
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover)),
                        Container(
                          margin: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(speakerName,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600)),
                              Text(speakerJob,
                                  style: TextStyle(
                                      color: AppColors.of(context).darkGray,
                                      fontSize: 13.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w400))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 16.0, top: 12.0, bottom: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColors.of(context).lightGray,
                                  width: 0.0))),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 8.0),
                              child: Text(talkTitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600)),
                            ),
                            Expanded(
                              child: Text(talkDescription,
                                  style: TextStyle(
                                      color: AppColors.of(context).darkGray,
                                      fontSize: 13.0,
                                      letterSpacing: 0.87,
                                      fontWeight: FontWeight.w500,
                                      height: 1.38),
                                  overflow: TextOverflow.fade),
                            )
                          ]),
                    ),
                  ),
                  Container(
                      child: Center(
                          child: CupertinoButton(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Image.asset('images/dots.png'),
                                  ),
                                  Text('READ MORE',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.67)),
                                ],
                              ),
                              onPressed: onReadMoreTap,
                              pressedOpacity: 0.5)))
                ],
              ),
            )));
  }
}
