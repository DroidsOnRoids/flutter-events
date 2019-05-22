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

import 'package:events/models/photo.dart';
import 'package:events/pages/photo_gallery/photo_gallery_page.dart';
import 'package:events/utils/app_colors.dart';
import 'package:events/widgets/navigation_bar.dart';
import 'package:events/widgets/placeholder_image.dart';
import 'package:events/widgets/tap_detector.dart';
import 'package:flutter/cupertino.dart';

import 'blocs/photos_list_bloc.dart';

class PhotosListPage extends StatefulWidget {
  final PhotosListBlocType _bloc;

  PhotosListPage({@required PhotosListBlocType bloc})
      : assert(bloc != null),
        _bloc = bloc;

  PhotosListPage.build({@required List<Photo> photos})
      : this(bloc: PhotosListBlocType.build(photos: photos));

  @override
  _PhotosListPageState createState() => _PhotosListPageState();
}

class _PhotosListPageState extends State<PhotosListPage> {
  PhotosListBlocType get _bloc => widget._bloc;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: NavigationBar(title: 'PHOTOS'),
        child: SafeArea(
          child: Container(
              color: AppColors.of(context).lightGray,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: _bloc.photos.length,
                  itemBuilder: (context, index) => _buildPhoto(context, index),
                  padding: EdgeInsets.all(4.0))),
        ));
  }

  Widget _buildPhoto(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(4.0),
      child: TapDetector(
        childBuilder: (isPressed) => Opacity(
              opacity: isPressed ? 0.75 : 1.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Hero(
                  transitionOnUserGestures: true,
                  tag: index,
                  child: PlaceholderImage(
                      image: NetworkImage(_bloc.photos[index].thumbUrl),
                      placeholder: AssetImage('images/event_placeholder.png'),  // TODO: Replace placeholder
                      fit: BoxFit.cover),
                ),
              ),
            ),
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(CupertinoPageRoute(
              builder: (context) => PhotoGalleryPage(heroId: index)));
        },
      ),
    );
  }
}
