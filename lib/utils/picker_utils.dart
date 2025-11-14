
import 'package:image_picker/image_picker.dart';

class ImagePickerUtils{

  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImageFromGalleryAndCamera(ImageSource source)async{
    XFile? file =  await picker.pickImage(source: source);
    return file;
  }

}