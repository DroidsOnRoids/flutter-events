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

import 'package:events/services/network_provider.dart';
import 'package:events/utils/disposable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'event_details_bloc_states.dart';

abstract class EventDetailsBlocType implements Disposable {
  factory EventDetailsBlocType.build({@required int eventId}) =>
      EventDetailsBloc(eventId: eventId, provider: NetworkProviderType.build());

  Stream<EventDetailsBlocState> get stream;

  void fetch();

  void onTryAgainTap();
}

class EventDetailsBloc implements EventDetailsBlocType {
  final int _eventId;
  final NetworkProviderType _provider;

  EventDetailsBloc(
      {@required int eventId, @required NetworkProviderType provider})
      : assert(eventId != null),
        assert(provider != null),
        _eventId = eventId,
        _provider = provider;

  final _streamController = StreamController<EventDetailsBlocState>();

  @override
  Stream<EventDetailsBlocState> get stream => _streamController.stream;

  @override
  void fetch() async {
    _streamController.add(EventDetailsBlocLoadingState());

    try {
      final lastEvent = await _provider.fetchEvent(id: _eventId);

      final dateFormatter = DateFormat('dd.MM.yyy');
      final timeFormatter = DateFormat('HH:mm \'CET\'');

      final cardStates = lastEvent.talks
          .map((talk) => EventDetailsBlocCardContentState(
              speakerImageUrl: talk.speaker.avatar.thumbUrl,
              speakerName: talk.speaker.name,
              speakerJob: talk.speaker.job,
              talkTitle: talk.title,
              talkDescription: talk.description))
          .toList();

      _streamController.add(EventDetailsBlocContentState(
          title: lastEvent.title.toUpperCase(),
          coverImageUrls:
              lastEvent.coverImages.map((photo) => photo.bigUrl).toList(),
          subtitle: 'iOS Developers Meetup',
          placeName: lastEvent.placeName.toUpperCase(),
          placeStreet: lastEvent.placeStreet.replaceAll(', ', ',\n'),
          date: dateFormatter.format(lastEvent.date),
          time: timeFormatter.format(lastEvent.date),
          photos: lastEvent.photos,
          cardStates: cardStates));
    } catch (e) {
      _streamController.add(EventDetailsBlocErrorState(error: e.toString()));
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
