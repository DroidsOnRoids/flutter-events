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

class PlaceholderImage extends StatelessWidget {
  PlaceholderImage(
      {@required this.image,
      @required this.placeholder,
      this.width,
      this.height,
      this.fit,
      this.alignment = Alignment.center,
      this.repeat = ImageRepeat.noRepeat})
      : assert(image != null),
        assert(placeholder != null),
        assert(alignment != null),
        assert(repeat != null);

  final ImageProvider image;
  final ImageProvider placeholder;
  final double width;
  final double height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        image: image,
        placeholder: placeholder,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        repeat: repeat);
  }
}
