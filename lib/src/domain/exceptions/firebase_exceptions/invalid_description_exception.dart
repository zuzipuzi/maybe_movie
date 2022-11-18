import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class InvalidDescriptionException extends BaseException {
  const InvalidDescriptionException(String message) : super(message);
}
