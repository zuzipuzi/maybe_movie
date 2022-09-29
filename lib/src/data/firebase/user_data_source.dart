import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/firebase/image_data_source.dart';

@LazySingleton()
class UserDataSource {
  UserDataSource(this._firebaseAuth);

  final firebase.FirebaseAuth _firebaseAuth;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  User? get user => _firebaseAuth.currentUser!;

  Future<DocumentSnapshot> getUserInfo() async {
    final userSnapshot = await _usersCollection.doc(user!.uid).get();
    return userSnapshot;
  }

  Future<bool> isUserExist() async {
    DocumentSnapshot userSnapshot = await _usersCollection.doc(user!.uid).get();
    return userSnapshot.exists;
  }

  Future<void> createUser({
    required String email,
    required String name,
  }) async {
    return await _usersCollection.doc(user!.uid).set({
      'id': user!.uid,
      'email': email,
      'name': name,
      'image': '',
      "favoritesMoviesIds": [],
      'language': 'en',
      'theme': 'dark',
    });
  }

  Future<void> createUserGoogle({
    required String email,
    required String? name,
    required String? image,
  }) async {
    return await _usersCollection.doc(user!.uid).set({
      'id': user!.uid,
      'email': email,
      'name': name ?? email,
      'image': image?.replaceAll('s96-c', 's192-c') ?? '',
      "favoritesMoviesIds": [],
      'language': 'en',
      'theme': 'light',
    });
  }

  Future<void> updateProfileData({
    required String name,
    required String email,
  }) async {
    await user!.updateEmail(email);
    await user!.updateDisplayName(name);
    return await _usersCollection.doc(user!.uid).update({
      'email': email,
      'name': name,
    });
  }

  Future<void> updateSettingData({
    required String theme,
    required String language,
  }) async {
    return await _usersCollection.doc(user!.uid).update({
      'theme': theme,
      'language': language,
    });
  }

  Future<void> updateImageData({
    required File image,
  }) async {
    final imageUrl = image.path.isNotEmpty
        ? await createImage(image, user!.email, "photo")
        : '';
    await user!.updatePhotoURL(imageUrl);
    return await _usersCollection.doc(user!.uid).update({
      'image': imageUrl,
    });
  }
}
