import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neop_task/domain/repositry/all_movies_repo/all_movies_repo.dart';

import '../../../../core/utiles/utiles.dart';
import '../../../../cubit/app_cubit.dart';
import '../../../../domain/models/movies_model.dart';

part 'all_movies_state.dart';

class AllMoviesCubit extends Cubit<AllMoviesState> {
  AllMoviesCubit() : super(AllMoviesInitial());
  static AllMoviesCubit get(context) => BlocProvider.of(context);
  List<MoviesModel> movies = [];
  Timer? searchOnStoppedTyping;

  getAllMovies({String? search}) async {
    emit(AllMoviesLoading());

    final response = await AllMoviesRepo.fetchAllMovies(search: search);
    if (response != null) {
      movies = response;
      emit(AllMoviesSuccess());
    } else {
      emit(AllMoviesError());
    }
  }

  onChangeHandler(value) {
    const duration = Duration(milliseconds: 500);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
      emit(StartTimerMessagesSuccess());
    }
    searchOnStoppedTyping = Timer(duration, () {
      getAllMovies(search: value);
      emit(EndTimerMessagesSuccess());
    });
  }

  changeMode(context) {
    Utiles.appMode =
        (Utiles.appMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    final app = AppCubit.get(context);

    app.emit(ChangeStateApp());
  }
}
