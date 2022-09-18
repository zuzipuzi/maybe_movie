import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class InvalidEmailException extends BaseException {
  const InvalidEmailException(String message) : super(message);
}
