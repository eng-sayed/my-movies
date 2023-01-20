part of 'all_movies_cubit.dart';

@immutable
abstract class AllMoviesState {}

class AllMoviesInitial extends AllMoviesState {}

class AllMoviesLoading extends AllMoviesState {}

class AllMoviesError extends AllMoviesState {}

class AllMoviesSuccess extends AllMoviesState {}

class StartTimerMessagesSuccess extends AllMoviesState {}

class EndTimerMessagesSuccess extends AllMoviesState {}
