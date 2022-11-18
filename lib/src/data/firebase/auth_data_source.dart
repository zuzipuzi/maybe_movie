import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:injectable/injectable.dart';
import 'package:google_sign_in/google_sign_in.dart';

@LazySingleton()
class AuthDataSource {
  AuthDataSource(
    this._firebaseAuth,
    this._googleAuth,
  );

  final firebase.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleAuth;

  bool checkUserAuthStatus() {
    final userId = _firebaseAuth.currentUser?.uid;
    return userId != null || userId == "";
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<firebase.User?> logInWithGoogle() async {
    final googleUser = await _googleAuth.signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = firebase.GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    final response = await _firebaseAuth.signInWithCredential(credential);

    return response.user;
  }

  Future<void> logOut() async {
    _googleAuth.signOut();
    _firebaseAuth.signOut();
  }

  Future<void> register({
    required String email,
    required String name,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
