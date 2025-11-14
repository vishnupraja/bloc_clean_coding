import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../bloc/image_picker_bloc/picker_bloc.dart';
import '../utils/picker_utils.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PickerBloc(pickerUtils: ImagePickerUtils()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("imagePicker"),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    context.read<PickerBloc>().add(const PickImage(imageSource: ImageSource.gallery));
                  }, icon: const Icon(Icons.image)),
                  BlocBuilder<PickerBloc,PickerState>(
                    builder: (context, state) {
                    return state.file != null ? Image.file(File(state.file!.path,),height: 250,width: 300,) : const SizedBox();
                  },)
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
