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

import 'package:events/pages/speakers_list/blocs/speakers_list_bloc_states.dart';
import 'package:events/services/network_provider.dart';
import 'package:events/utils/disposable.dart';
import 'package:meta/meta.dart';

abstract class SpeakersListBlocType implements Disposable {
  factory SpeakersListBlocType.build() =>
      SpeakersListBloc(provider: NetworkProviderType.build());

  Stream<SpeakersListBlocState> get stream;

  void fetch();

  void onTryAgainTap();
}

class SpeakersListBloc implements SpeakersListBlocType {
  final NetworkProviderType _provider;

  SpeakersListBloc({@required NetworkProviderType provider})
      : assert(provider != null),
        _provider = provider;

  final _streamController = StreamController<SpeakersListBlocState>();

  @override
  Stream<SpeakersListBlocState> get stream => _streamController.stream;

  @override
  void fetch() async {
    _streamController.add(SpeakersListBlocLoadingState());

    try {
      final recentSpeakers = await _provider.fetchSpeakersList(recent: true);
      final speakersList = await _provider.fetchSpeakersList(recent: false);

      final recentSpeakersStates = recentSpeakers
          .map((speaker) => SpeakersListBlocCardContentState(
              speakerId: speaker.id,
              thumbnailImageUrl: speaker.avatar.bigUrl,
              name: () {
                final nameComponents = speaker.name.split(' ');

                if (nameComponents.length > 1) {
                  final firstName = nameComponents.first;
                  final lastName = nameComponents.last;

                  return firstName + '\n' + lastName;
                } else {
                  return speaker.name;
                }
              }(),
              job: speaker.job))
          .toList();

      final speakersListStates = speakersList
          .map((speaker) => SpeakersListBlocCardContentState(
              speakerId: speaker.id,
              thumbnailImageUrl: speaker.avatar.thumbUrl,
              name: speaker.name,
              job: speaker.job))
          .toList();

      _streamController.add(SpeakersListBlocContentState(
          recentSpeakers: recentSpeakersStates,
          speakersList: speakersListStates));
    } catch (e) {
      _streamController.add(SpeakersListBlocErrorState(error: e.toString()));
    }
  }

  @override
  void onTryAgainTap() {
    fetch();
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
