
import 'package:flutter_clean_coding/model/favorite/favorite_model.dart';

abstract class FavoriteRepository{

  Future<List<FavoriteModel>> getData();

}