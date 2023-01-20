import '../../../data/api/my_api.dart';
import '../../endpoints/endpoints.dart';
import '../../models/movie_detailes_model.dart';
import '../../models/movies_model.dart';

class AllMoviesRepo {
  static fetchAllMovies({String? search}) async {
    List<MoviesModel> movies = [];
    String searchKey = (search?.isNotEmpty ?? false) ? (search ?? '') : 'conj';
    final response = await DioHelper.getData(
        url: EndPoints.SEARCH, loading: false, query: {"query": searchKey});
    print(response);
    if (response != null) {
      response.data['results'].forEach((e) {
        movies.add(MoviesModel.fromJson(e));
      });
      return movies;
    }
  }

  static Future<MovieDetailesModel?> fetchOneMovie(String movieId) async {
    MovieDetailesModel? movieDetailesModel;
    final response = await DioHelper.getData(
      url: EndPoints.TITLE + movieId,
      loading: false,
    );
    print(response);
    if (response != null) {
      movieDetailesModel = MovieDetailesModel.fromJson(response.data);
      return movieDetailesModel;
    }
  }
}
