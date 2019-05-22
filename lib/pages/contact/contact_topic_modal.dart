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
import 'package:events/widgets/tap_detector.dart';
import 'package:flutter/cupertino.dart';

class ContactTopicModal extends StatelessWidget {
  final List<String> children;

  ContactTopicModal({@required this.children}) : assert(children != null);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: AppColors.of(context).white, boxShadow: [
          BoxShadow(
              color: AppColors.of(context).black.withAlpha(25),
              blurRadius: 15.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, -5.0))
        ]),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColors.of(context).lightGray,
                              width: 0.0))),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Text('I want to...',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.67)),
                      Align(
                          alignment: Alignment.centerRight,
                          child: CupertinoButton(
                              pressedOpacity: 0.5,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Done',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.67))))
                    ],
                  )),
              Container(
                  height: 312,
                  child: ListView.builder(
                    itemCount: children.length,
                    itemBuilder: (context, index) => _buildCard(
                        context: context,
                        text: children[index],
                        showsBottomBorder: index < children.length - 1,
                        onTap: () {
                          Navigator.pop(context, index);
                        }),
                    padding: EdgeInsets.zero,
                  ))
            ]));
  }

  Widget _buildCard(
      {BuildContext context,
      String text,
      bool showsBottomBorder,
      GestureTapCallback onTap}) {
    return TapDetector(
        onTap: onTap,
        childBuilder: (isPressed) => AnimatedContainer(
            decoration: BoxDecoration(
                color: isPressed
                    ? AppColors.of(context).lightGray.withAlpha(128)
                    : null),
            duration: Duration(milliseconds: 100),
            child: Container(
                margin: EdgeInsets.only(left: 16.0),
                padding: EdgeInsets.only(top: 16.0, bottom: 16.0, right: 16.0),
                decoration: BoxDecoration(
                    border: showsBottomBorder
                        ? Border(
                            bottom: BorderSide(
                                color: AppColors.of(context).lightGray,
                                width: 0.0))
                        : null),
                child: Text(text,
                    style: TextStyle(
                        color: AppColors.of(context).darkGray,
                        letterSpacing: 1.0,
                        fontSize: 14.0)))));
  }
}
