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

import 'package:events/widgets/dots_indicator.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:flutter/widgets.dart';

class ImageSlider extends StatefulWidget {
  ImageSlider({@required this.imageUrls}) : assert(imageUrls != null);

  final List<String> imageUrls;

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('images/cover_placeholder.png');
    final pages = widget.imageUrls.isEmpty
        ? [Image(image: placeholder, fit: BoxFit.cover)]
        : widget.imageUrls
            .map((imageUrl) => PlaceholderImage(
                image: imageUrl != null ? NetworkImage(imageUrl) : placeholder,
                placeholder: placeholder,
                fit: BoxFit.cover))
            .toList();

    return Container(
        child: Stack(children: [
      AspectRatio(
          aspectRatio: 1.62,
          child: PageView(
            onPageChanged: (page) => {
                  setState(() {
                    _currentPage = page;
                  })
                },
            children: pages,
          )),
      if (widget.imageUrls.length > 1)
        Positioned.fill(
            bottom: 5.0,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  numberOfDots: widget.imageUrls.length,
                  highlightedDot: _currentPage,
                  hasShadow: true,
                )))
    ]));
  }
}
