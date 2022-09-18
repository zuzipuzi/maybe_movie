import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class InvalidTitleException extends BaseException {
  const InvalidTitleException(String message) : super(message);
}
