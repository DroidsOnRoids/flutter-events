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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:events/services/network_provider.dart';
import 'package:events/utils/disposable.dart';

import 'events_list_bloc_states.dart';

abstract class EventsListBlocType implements Disposable {
  factory EventsListBlocType.build() =>
      EventsListBloc(provider: NetworkProviderType.build());

  Stream<EventsListBlocState> get stream;

  void fetch();

  void onTryAgainTap();
}

class EventsListBloc implements EventsListBlocType {
  final NetworkProviderType _provider;

  EventsListBloc({@required NetworkProviderType provider})
      : assert(provider != null),
        _provider = provider;

  final _streamController = StreamController<EventsListBlocState>();

  @override
  Stream<EventsListBlocState> get stream => _streamController.stream;

  @override
  void fetch() async {
    _streamController.add(EventsListBlocLoadingState());

    try {
      final eventsList = await _provider.fetchEventsList();
      final lastEvent = await _provider.fetchEvent(id: eventsList.first.id);

      final dateFormatter = DateFormat('dd.MM.yyy');
      final timeFormatter = DateFormat('HH:mm \'CET\'');

      final cardStates = eventsList
          .skip(1)
          .map((event) => EventsListBlocCardContentState(
              eventId: event.id,
              thumbnailImageUrl: event.coverImages.isNotEmpty
                  ? event.coverImages.first.thumbUrl
                  : null,
              title: event.title.toUpperCase(),
              date: dateFormatter.format(event.date)))
          .toList();

      _streamController.add(EventsListBlocContentState(
          eventId: lastEvent.id,
          title: lastEvent.title.toUpperCase(),
          coverImageUrl: lastEvent.coverImages.isNotEmpty
              ? lastEvent.coverImages.first.bigUrl
              : null,
          subtitle: 'iOS Developers Meetup',
          placeName: lastEvent.placeName.toUpperCase(),
          placeStreet: lastEvent.placeStreet.replaceAll(', ', ',\n'),
          date: dateFormatter.format(lastEvent.date),
          time: timeFormatter.format(lastEvent.date),
          cardStates: cardStates));
    } catch (e) {
      _streamController.add(EventsListBlocErrorState(error: e.toString()));
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
