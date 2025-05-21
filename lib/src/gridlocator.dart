import 'dart:convert';
import 'util/gridlocator_exception.dart';

class Gridlocator {
  /// Constructor, Take the latitude and longitude as arguments
  const Gridlocator(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  @override
  String toString() {
    return '$latitude, $longitude, ${encode()}';
  }

  /// Returns to gridlocator string
  String encode() {
    return _encode(this);
  }

  /// Returns to Gridlocator Object
  /// takes a gridlocator string as an argument
  ///
  /// Throws a [GridlocatorException].
  static Gridlocator decode(String mhstring) {
    return _decode(mhstring);
  }
}

String _encode(Gridlocator m) {
  var lat = m.latitude + 90;
  var lng = m.longitude + 180;

  // Field
  lat = lat / 10;
  lng = lng / 20;

  var locator = '';
  locator += _n2l(lng.floor(), true);
  locator += _n2l(lat.floor(), true);

  // Square
  lng = 10 * (lng - lng.floor());
  lat = 10 * (lat - lat.floor());
  locator += lng.floor().toString();
  locator += lat.floor().toString();

  // Subsquare
  lng = 24 * (lng - lng.floor());
  lat = 24 * (lat - lat.floor());
  locator += _n2l(lng.floor(), false);
  locator += _n2l(lat.floor(), false);

  return locator;
}

Gridlocator _decode(String glstring) {
  if (glstring.length != 6) {
    throw GridlocatorException('Invalid argument must be 6 digit');
  }

  final lint = <int>[
    // Field
    _l2n(glstring.substring(0, 1)),
    _l2n(glstring.substring(1, 2)),

    // Square
    int.parse(glstring.substring(2, 3)),
    int.parse(glstring.substring(3, 4)),

    // Subsquare
    _l2n(glstring.substring(4, 5)),
    _l2n(glstring.substring(5, 6)),
  ];

  final lng = (lint[0].toDouble() * 20) +
      (lint[2].toDouble() * 2) +
      (lint[4].toDouble() / 12) -
      180;

  final lat = (lint[1].toDouble() * 10) +
      lint[3].toDouble() +
      (lint[5].toDouble() / 24) -
      90;

  return Gridlocator(lat, lng);
}

String _n2l(int number, bool uppercase) {
  if (number > 0x17) {
    throw GridlocatorException('Invalid number is out of range');
  }
  final n = number + 0x61;
  final result = const AsciiDecoder().convert([n]);

  if (uppercase) {
    return result.toUpperCase();
  }
  return result.toLowerCase();
}

int _l2n(String letter) {
  final bytes = utf8.encode(letter.toLowerCase());
  if (bytes[0] >= 0x61 && bytes[0] <= 0x78) {
    return bytes[0] - 0x61;
  }
  return 0;
}
