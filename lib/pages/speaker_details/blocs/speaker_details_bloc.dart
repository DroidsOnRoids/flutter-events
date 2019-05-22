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

import 'package:events/pages/speaker_details/blocs/speaker_details_bloc_states.dart';
import 'package:events/services/network_provider.dart';
import 'package:events/utils/disposable.dart';
import 'package:meta/meta.dart';

abstract class SpeakerDetailsBlocType implements Disposable {
  factory SpeakerDetailsBlocType.build({@required int speakerId}) =>
      SpeakerDetailsBloc(
          speakerId: speakerId, provider: NetworkProviderType.build());

  Stream<SpeakerDetailsBlocState> get stream;

  void fetch();

  void onTryAgainTap();
}

class SpeakerDetailsBloc implements SpeakerDetailsBlocType {
  final int _speakerId;
  final NetworkProviderType _provider;

  SpeakerDetailsBloc(
      {@required int speakerId, @required NetworkProviderType provider})
      : assert(speakerId != null),
        assert(provider != null),
        _speakerId = speakerId,
        _provider = provider;

  final _streamController = StreamController<SpeakerDetailsBlocState>();

  @override
  Stream<SpeakerDetailsBlocState> get stream => _streamController.stream;

  @override
  void fetch() async {
    _streamController.add(SpeakerDetailsBlocLoadingState());

    try {
      final speaker = await _provider.fetchSpeaker(id: _speakerId);

      final cards = speaker.talks
          .map((talk) => SpeakerDetailsBlocCardContentState(
              speakerImageUrl: speaker.avatar.thumbUrl,
              speakerName: speaker.name,
              speakerJob: speaker.job,
              talkTitle: talk.title,
              talkDescription: talk.description))
          .toList();

      _streamController.add(SpeakerDetailsBlocContentState(
          avatarUrl: speaker.avatar.thumbUrl,
          name: speaker.name,
          job: speaker.job,
          bio: speaker.bio,
          cards: cards));
    } catch (e) {
      _streamController.add(SpeakerDetailsBlocErrorState(error: e.toString()));
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
