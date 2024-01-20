import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
}

pickImages() async {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? files = await imagePicker.pickMultiImage();

  return await Future.wait(
    files.map(
      (file) => file.readAsBytes(),
    ),
  );
}

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
