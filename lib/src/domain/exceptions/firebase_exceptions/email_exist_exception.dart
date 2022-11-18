import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class EmailAlreadyExistException extends BaseException {
  const EmailAlreadyExistException(String message) : super(message);
}
