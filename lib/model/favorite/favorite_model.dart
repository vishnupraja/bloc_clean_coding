

import 'package:equatable/equatable.dart';

class FavoriteModel extends Equatable{
  final String id;
  final String name;
  final bool favorite;
  final bool delete;

  const FavoriteModel({
    required this.id,
    required this.name,
     this.favorite = false,
     this.delete = false,
  });

   FavoriteModel copyWith({String? id,String? name,bool? favorite,bool? delete}){
    return FavoriteModel(
        id: id ?? this.id,
        name: name ?? this.name,
        favorite: favorite ?? this.favorite,
        delete: delete ?? this.delete,
    );
  }

  @override
  List<Object> get props => [id,name,favorite,delete];

}