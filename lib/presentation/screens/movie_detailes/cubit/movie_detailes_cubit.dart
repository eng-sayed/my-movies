import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neop_task/domain/repositry/all_movies_repo/all_movies_repo.dart';

import '../../../../domain/models/movie_detailes_model.dart';

part 'movie_detailes_state.dart';

class MovieDetailesCubit extends Cubit<MovieDetailesState> {
  MovieDetailesCubit() : super(MovieDetailesInitial());
  static MovieDetailesCubit get(context) => BlocProvider.of(context);
  MovieDetailesModel? movieDetailesModel;

  getOneMovie(String idMovie) async {
    emit(MovieDetailesLoading());
    final response = await AllMoviesRepo.fetchOneMovie(idMovie);
    if (response != null) {
      movieDetailesModel = response;
      emit(MovieDetailesSuccess());
    } else {
      emit(MovieDetailesError());
    }
  }
}
