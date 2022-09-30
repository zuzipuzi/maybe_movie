import 'dart:math';

class IdGenerator{
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final _rnd = Random();

  static String getRandomId() {
    return String.fromCharCodes(
      Iterable.generate(
        20,
            (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
  }
}