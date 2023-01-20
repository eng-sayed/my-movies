part of 'movie_detailes_cubit.dart';

@immutable
abstract class MovieDetailesState {}

class MovieDetailesInitial extends MovieDetailesState {}

class MovieDetailesLoading extends MovieDetailesState {}

class MovieDetailesError extends MovieDetailesState {}

class MovieDetailesSuccess extends MovieDetailesState {}
