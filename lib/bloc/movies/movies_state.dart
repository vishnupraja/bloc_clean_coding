part of 'movies_bloc.dart';

class MoviesStates extends Equatable{
  final ApiResponse<MovieModel> moviesList;
  final int currentPage;
  final bool isLoadingMore;
  const MoviesStates({required this.moviesList,this.currentPage = 1, this.isLoadingMore = false});

  MoviesStates copyWith({
    ApiResponse<MovieModel>? moviesList,
    int? currentPage,
    bool? isLoadingMore
  }){
    return MoviesStates(
        moviesList: moviesList ?? this.moviesList,
        currentPage: currentPage ?? this.currentPage,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore
    );
  }

  @override
  List<Object> get props => [moviesList,currentPage,isLoadingMore];
}