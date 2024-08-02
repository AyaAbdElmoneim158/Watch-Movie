import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/api_service.dart';
import 'event_details.dart';
import 'state_details.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, DetailsState> {
  MovieDetailBloc() : super(DetailsLoading());

  Stream<DetailsState> mapEventToState(MovieDetailEvent event) async* {
    if (event is MovieDetailEventStated) {
      yield* _mapMovieEventStartedToState(event.id);
    }
  }

  Stream<DetailsState> _mapMovieEventStartedToState(int id) async* {
    final apiRepository = ApiService();
    yield DetailsLoading();
    try {
      final movieDetail = await apiRepository.getMovieDetail(id);

      yield DetailsLoaded(movieDetail);
    } on Exception catch (e) {
      debugPrint(e.toString());
      yield DetailsError();
    }
  }
}
