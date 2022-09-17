import 'package:flutter/cupertino.dart';
import 'package:maybe_movie/src/domain/exceptions/base_exception.dart';

@immutable
class ConnectionException extends BaseException {
  const ConnectionException(String message) : super(message);
}
