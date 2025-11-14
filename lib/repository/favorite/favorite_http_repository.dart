
import 'package:flutter_clean_coding/repository/favorite/favorite_repo.dart';

import '../../model/favorite/favorite_model.dart';

class FavoriteHttpRepository implements FavoriteRepository{

  @override
  Future<List<FavoriteModel>> getData() async{
    await Future.delayed(const Duration(seconds: 3,));
    return List.of(_buildList(10));
  }

  List<FavoriteModel> _buildList(int item) {
    return  List.generate(item, (index) => FavoriteModel(id: index.toString(), name: "Goal ${index.toString()}"),);
  }

}