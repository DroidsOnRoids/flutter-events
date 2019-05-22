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

class TapDetector extends StatefulWidget {
  TapDetector({@required this.childBuilder, this.onTap})
      : assert(childBuilder != null);

  final Widget Function(bool isPressed) childBuilder;
  final GestureTapCallback onTap;

  @override
  _TapDetectorState createState() => _TapDetectorState();
}

class _TapDetectorState extends State<TapDetector> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onPointerUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      child: GestureDetector(
          onTap: widget.onTap, child: widget.childBuilder(_isPressed)),
    );
  }
}
