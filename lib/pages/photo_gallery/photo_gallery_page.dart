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

import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:flutter/cupertino.dart';

class PhotoGalleryPage extends StatelessWidget {
  PhotoGalleryPage({this.heroId});

  final int heroId;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'PHOTO'),
        child: Center(
            child: Hero(
                transitionOnUserGestures: true,
                tag: heroId,
                child: PlaceholderImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
                    placeholder: AssetImage('images/event_placeholder.png'),  // TODO: Replace placeholder
                    fit: BoxFit.cover))));
  }
}
