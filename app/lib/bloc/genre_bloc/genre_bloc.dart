import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/genre.dart';
import '../../service/api_service.dart';
import 'genre_bloc_event.dart';
import 'genre_bloc_state.dart';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(GenreLoading());

  Stream<GenreState> mapEventToState(GenreEvent event) async* {
    if (event is GenreEventStarted) {
      yield* _mapEventStableToState();
    }
  }

  Stream<GenreState> _mapEventStableToState() async* {
    final service = ApiService();
    yield GenreLoading();
    try {
      late List<Genre> genreList;
      genreList = await service.getGenreList();
      yield GenreLoaded(genreList);
    } on Exception catch (e) {
      debugPrint(e.toString());
      yield GenreError();
    }
  }
}
