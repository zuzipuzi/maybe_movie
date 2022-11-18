import 'package:flutter/material.dart';

@immutable
class BaseException implements Exception {
  const BaseException(this.message);

  final String message;
}
