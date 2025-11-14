import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_coding/data/response/api_response.dart';
import 'package:flutter_clean_coding/model/favorite/favorite_model.dart';

import '../../repository/favorite/favorite_repo.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteStates>{
  final FavoriteRepository favoriteRepository;
  List<FavoriteModel> favoriteList =[];
  List<FavoriteModel> tempList =[];
     FavoriteBloc({required this.favoriteRepository}): super( FavoriteStates(favoriteList: ApiResponse.loading())){
       on<GetFavoriteData>(_onGetFavoriteData);
       on<AddFavorite>(_addFavouriteById);
       on<SelectItem>(_selectItem);
       on<UnSelectItem>(_unSelectItem);
       on<DeleteItem>(_deleteItems);
     }
     void _onGetFavoriteData(GetFavoriteData event, Emitter<FavoriteStates> emit)async{
       await favoriteRepository.getData().then((value){
         favoriteList = value;
         emit(state.copyWith(favoriteList: ApiResponse.completed(value)));
       }).onError((error, stackTrace) {
         emit(state.copyWith(favoriteList: ApiResponse.error(error.toString())));
       },);
     }

  void _addFavouriteById(AddFavorite event, Emitter<FavoriteStates> emit) async {
    final index = favoriteList.indexWhere((element) => element.id == event.id);

    if (index != -1) {
      final currentItem = favoriteList[index];
      final updatedItem = currentItem.copyWith(favorite: !currentItem.favorite);

      favoriteList[index] = updatedItem;

      emit(state.copyWith(
        favoriteList: ApiResponse.completed(List.from(favoriteList)),
      ));
    }
  }

  void _selectItem(SelectItem event, Emitter<FavoriteStates> emit) {
    final item = favoriteList.firstWhere((element) => element.id == event.id,
      orElse: () => FavoriteModel(id: event.id, name: ''),
    );

    // Add to selection list if not already selected
    if (!tempList.any((e) => e.id == item.id)) {
      tempList.add(item);
      emit(state.copyWith(tempList: List.from(tempList)));
    }
  }

  void _unSelectItem(UnSelectItem event, Emitter<FavoriteStates> emit) {
    tempList.removeWhere((element) => element.id == event.id);
    emit(state.copyWith(tempList: List.from(tempList)));
  }

  void _deleteItems(DeleteItem event, Emitter<FavoriteStates> emit) {
    favoriteList.removeWhere((fav) => tempList.any((selected) => selected.id == fav.id),
    );
    tempList.clear();
    emit(state.copyWith(
      favoriteList: ApiResponse.completed(List.from(favoriteList)),
      tempList: List.from(tempList),
    ));
  }


}