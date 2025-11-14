
import '../../data/response/api_response.dart';
import '../../model/movies/movies.dart';

abstract class MoviesRepository{

 Future<MovieModel> getMovies({int page = 1});

}