import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_coding/utils/picker_utils.dart';
import 'package:image_picker/image_picker.dart';
part 'picker_event.dart';
part 'picker_state.dart';

class PickerBloc extends Bloc<PickerEvent,PickerState>{
  final ImagePickerUtils pickerUtils;
  PickerBloc({required this.pickerUtils}): super(const PickerState()){
    on<PickImage>(_pickImage);
  }

  void _pickImage(PickImage event, Emitter<PickerState> emit)async {
  final XFile? file =  await pickerUtils.pickImageFromGalleryAndCamera(event.imageSource ?? ImageSource.gallery);
   emit(state.copyWith(file: file));
  }

}