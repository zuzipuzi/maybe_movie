import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/connection_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/email_exist_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/invalid_email_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/invalid_password_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/user_not_found_exception.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton()
class FirebaseErrorMapper {
  final logger = getLogger('FirebaseErrorMapper');

  BaseException map(FirebaseException error) {
    logger.e('message: ${error.message} \n code: ${error.code}');

    switch (error.code) {
      case 'email-already-exists':
        return EmailAlreadyExistException(error.message ?? '');
      case 'invalid-email':
        return InvalidEmailException(error.message ?? '');
      case 'invalid-password':
        return InvalidPasswordException(error.message ?? '');
      case 'network-request-failed':
        return ConnectionException(error.message ?? '');
      case 'user-not-found':
        return UserNotFoundException(error.message ?? '');
      default:
        return BaseException(error.message ?? 'no message');
    }
  }
}
