import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/person.dart';
import '../../service/api_service.dart';
import 'person_bloc_event.dart';
import 'person_bloc_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  PersonBloc() : super(PersonLoading());

  Stream<PersonState> mapEventToState(PersonEvent event) async* {
    if (event is PersonEventStarted) {
      yield* _mapEventStableToState();
    }
  }

  Stream<PersonState> _mapEventStableToState() async* {
    final service = ApiService();
    yield PersonLoading();
    try {
      late List<Person> personList;
      personList = await service.getTrendingPerson();
      yield PersonLoaded(personList);
    } on Exception catch (e) {
      debugPrint(e.toString());
      yield PersonError();
    }
  }
}
