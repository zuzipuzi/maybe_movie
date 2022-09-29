import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';


Future<String> createImage(File file, email, String pathFolder) async {

  final path = '$email/images/$pathFolder/${Random().nextInt(1000)}}';
  final ref = FirebaseStorage.instance.ref().child(path);
  final uploadTask = ref.putFile(file);
  final snapshot = await uploadTask;
  final downloadUrl = await snapshot.ref.getDownloadURL();

  return downloadUrl;
}
