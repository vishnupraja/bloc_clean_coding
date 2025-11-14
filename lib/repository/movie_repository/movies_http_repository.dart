import 'package:flutter_clean_coding/config/app_urls/app_url.dart';
import 'package:flutter_clean_coding/data/network/network_api_service.dart';
import 'package:flutter_clean_coding/model/movies/movies.dart';
import 'package:flutter_clean_coding/repository/movie_repository/movies_repository.dart';

class MoviesHttpRepository implements MoviesRepository {
  final _api = NetworkApiServices();

  @override
  Future<MovieModel> getMovies({int page = 1}) async {
    final response = await _api.getData("${AppUrls.moviesUrl}?page=$page");
    return MovieModel.fromJson(response);
  }
}
