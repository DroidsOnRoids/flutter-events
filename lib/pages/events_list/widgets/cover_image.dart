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

class CoverImage extends StatelessWidget {
  CoverImage({this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final placeholder = AssetImage('images/cover_placeholder.png');

    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: AppColors.of(context).black.withAlpha(100),
              blurRadius: 16.0,
              spreadRadius: -8.0,
              offset: Offset(0.0, 8.0))
        ]),
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 2.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: AspectRatio(
                aspectRatio: 1.62,
                child: PlaceholderImage(
                    image:
                        imageUrl != null ? NetworkImage(imageUrl) : placeholder,
                    placeholder: placeholder,
                    fit: BoxFit.cover))));
  }
}
