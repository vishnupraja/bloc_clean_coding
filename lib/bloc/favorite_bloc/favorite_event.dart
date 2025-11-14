part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable{

  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class GetFavoriteData extends FavoriteEvent{}

class AddFavorite extends FavoriteEvent{
  final String id;
  const AddFavorite({required this.id});
}

class SelectItem extends FavoriteEvent{
  final String id;
  const SelectItem({required this.id});
}

class UnSelectItem extends FavoriteEvent{
  final String id;
  const UnSelectItem({required this.id});
}

class DeleteItem extends FavoriteEvent {}

