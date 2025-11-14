
import 'package:freezed_annotation/freezed_annotation.dart';
part 'movies.freezed.dart';
part 'movies.g.dart';
@freezed
class MovieModel with _$MovieModel{

  factory MovieModel({
    @Default(0) int total,
    @Default(0) int page,
    @Default(0) int pages,
    @Default([]) @JsonKey(name: "tv_shows") List<TvShows> tvShows,
}) = _MovieModel;

  factory MovieModel.fromJson(Map<String,dynamic> json) => _$MovieModelFromJson(json);

}

@freezed
class TvShows with _$TvShows{
  factory TvShows({
   @JsonKey(name: "name") @Default("") String name,
   @JsonKey(name: "permalink") @Default("") String permalink,
   @JsonKey(name: "start_date") @Default("") String startDate,
   @JsonKey(name: "end_date") @Default("") String endDate,
   @JsonKey(name: "country") @Default("") String country,
   @JsonKey(name: "network") @Default("") String network,
   @JsonKey(name: "status") @Default("") String status,
   @JsonKey(name: "image_thumbnail_path") @Default("") String imageThumbnail,
  }) = _TvShows;

  factory TvShows.fromJson(Map<String,dynamic> json) => _$TvShowsFromJson(json);

}

