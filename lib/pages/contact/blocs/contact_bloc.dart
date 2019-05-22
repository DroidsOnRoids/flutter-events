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

import 'dart:async';

import 'package:events/utils/disposable.dart';

abstract class ContactBlocType implements Disposable {
  factory ContactBlocType.build() => ContactBloc();

  List<String> get topics;

  Stream<String> get currentTopicStream;

  void onTopicSelected({int index});
}

class ContactBloc implements ContactBlocType {
  final _currentTopicStreamController = StreamController<String>();

  @override
  List<String> get topics =>
      ['Speak on the next event', 'Claim a reward', 'Become a partner'];

  @override
  Stream<String> get currentTopicStream => _currentTopicStreamController.stream;

  @override
  void dispose() {
    _currentTopicStreamController.close();
  }

  @override
  void onTopicSelected({int index}) {
    if (index == null) {
      _currentTopicStreamController.add(null);
    } else if (index >= 0 && index < topics.length) {
      final topic = topics[index];
      _currentTopicStreamController.add(topic);
    }
  }
}
