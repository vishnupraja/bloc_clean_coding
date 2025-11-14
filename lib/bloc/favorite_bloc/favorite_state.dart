part of 'favorite_bloc.dart';

class FavoriteStates extends Equatable{
  final ApiResponse<List<FavoriteModel>> favoriteList;
  final List<FavoriteModel> tempList;

  const FavoriteStates({required this.favoriteList, this.tempList = const []});

  FavoriteStates copyWith({ApiResponse<List<FavoriteModel>>? favoriteList,List<FavoriteModel>? tempList}){
    return FavoriteStates(
        favoriteList: favoriteList ?? this.favoriteList,
        tempList: tempList ?? this.tempList,
    );
  }

  @override
  List<Object> get props => [favoriteList,tempList];

}