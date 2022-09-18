import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> getFromGallery() async {
  final pickedFile = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
  );

  return pickedFile != null ? File(pickedFile.path) : null;
}