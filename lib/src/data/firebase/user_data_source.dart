import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

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
    required String password,
  }) async {
    return await _usersCollection.doc(user!.uid).set({
      'id': user!.uid,
      'email': email,
      'name': name,
      'image': '',
      'password': password,
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
      'image': image ?? '',
      'password': '',
      'language': 'en',
      'theme': 'dark',
    });
  }
}
