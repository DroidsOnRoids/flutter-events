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
import 'package:meta/meta.dart';

abstract class PhotosListBlocType {
  factory PhotosListBlocType.build({List<Photo> photos}) =>
      PhotosListBloc(photos: photos);

  List<Photo> get photos;
}

class PhotosListBloc implements PhotosListBlocType {
  PhotosListBloc({@required this.photos}) : assert(photos != null);

  @override
  final List<Photo> photos;
}
