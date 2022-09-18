import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class InvalidPasswordException extends BaseException {
  const InvalidPasswordException(String message) : super(message);
}
