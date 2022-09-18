import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class UserNotFoundException extends BaseException {
  const UserNotFoundException(String message) : super(message);
}
