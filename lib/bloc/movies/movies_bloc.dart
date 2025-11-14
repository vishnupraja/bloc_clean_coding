
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_coding/data/response/api_response.dart';
import 'package:flutter_clean_coding/model/movies/movies.dart';
import '../../repository/movie_repository/movies_repository.dart';
part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent,MoviesStates>{
    MoviesRepository moviesRepository;
   MoviesBloc({required this.moviesRepository}) : super(MoviesStates(moviesList: ApiResponse.loading())){
     on<MoviesFetch>(_onMoviesFetch);
     on<MoviesFetchLoadMore>(_onMoviesFetchLoadMore);
   }

    void _onMoviesFetch(MoviesFetch event, Emitter<MoviesStates> emit) async {
      await _fetchMovies(emit: emit, page: 1);
    }

    void _onMoviesFetchLoadMore(MoviesFetchLoadMore event, Emitter<MoviesStates> emit) async {
      await _fetchMovies(emit: emit, page: state.currentPage + 1, isLoadMore: true);
    }


    Future<void> _fetchMovies({required Emitter<MoviesStates> emit, int page = 1, bool isLoadMore = false,}) async {
      if (isLoadMore && (state.isLoadingMore || state.moviesList.data == null)) return;
      if (isLoadMore) emit(state.copyWith(isLoadingMore: true));

      try {
        final value = await moviesRepository.getMovies(page: page);

        if (isLoadMore) {
          if (value.tvShows.isEmpty) {
            emit(state.copyWith(isLoadingMore: false));
            return;
          }

          final mergedList = [...state.moviesList.data!.tvShows, ...value.tvShows];
          final updatedModel = MovieModel(tvShows: mergedList);

          emit(state.copyWith(
            moviesList: ApiResponse.completed(updatedModel),
            currentPage: page,
            isLoadingMore: false,
          ));
          final apiResponse = ApiResponse.completed(value);
          if (kDebugMode) {
            print(apiResponse);
          }
        } else {
          emit(state.copyWith(
            moviesList: ApiResponse.completed(value),
            currentPage: 1,
          ));
        }

      } catch (error) {
        emit(state.copyWith(moviesList: ApiResponse.error(error.toString())));
      }
    }


}