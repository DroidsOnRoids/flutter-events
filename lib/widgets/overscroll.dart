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

class Overscroll extends StatefulWidget {
  final Widget child;

  Overscroll({this.child});

  @override
  _OverscrollState createState() => _OverscrollState();
}

class _OverscrollState extends State<Overscroll> {
  double _overscroll;

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.depth > 0) return;

            final overscroll = notification.metrics.pixels -
                notification.metrics.maxScrollExtent;

            setState(() {
              _overscroll = overscroll > 0.0 ? overscroll.ceilToDouble() : null;
            });
          },
          child: widget.child),
      if (_overscroll != null)
        Align(
          child: Container(
            color: Color.fromRGBO(211, 218, 227, 1.0),
            height: _overscroll,
          ),
          alignment: Alignment.bottomCenter,
        ),
    ]);
  }
}
