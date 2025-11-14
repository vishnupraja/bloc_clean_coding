part of 'picker_bloc.dart';

abstract class PickerEvent extends Equatable{
  const PickerEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends PickerEvent{
final ImageSource? imageSource;
const PickImage({ required this.imageSource});
}