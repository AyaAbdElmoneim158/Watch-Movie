import 'package:equatable/equatable.dart';

import '../../model/movie_details.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
  @override
  List<Object> get props => [];
}

class DetailsLoading extends DetailsState {}

class DetailsLoaded extends DetailsState {
  final MovieDetail details;
  const DetailsLoaded(this.details);

  @override
  List<Object> get props => [details];
}

class DetailsError extends DetailsState {}
