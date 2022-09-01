import 'package:flutter_test/flutter_test.dart';
import 'package:maidenhead/maidenhead.dart';

class _T {
  const _T(this.maidenhead, this.latitude, this.longitude);
  final String maidenhead;
  final double latitude;
  final double longitude;
}

void main() {
  final targets = <_T>[
    const _T('JJ00aa', 0, 0),
    const _T('JN58td', 48.146666666666667, 11.608333333333333),
    const _T('GF15vc', -34.91, -56.211666666666667),
    const _T('FM18lw', 38.92, -77.065),
    const _T('RE78ir', -41.291666666666664, 174.66666666666669),
  ];

  targets.asMap().forEach((int _, _T t) {
    test('Test Maidenhead Encode | [${t.maidenhead}]', () {
      expect(
        Maidenhead(t.latitude, t.longitude).encode(),
        t.maidenhead,
      );
    });

    test('Test Maidenhead Decode | [${t.maidenhead}]', () {
      expect(
        Maidenhead.decode(t.maidenhead).latitude,
        closeTo(t.latitude, .1),
      );
      expect(
        Maidenhead.decode(t.maidenhead).longitude,
        closeTo(t.longitude, .1),
      );
    });
  });

  const digit5 = 'JJ00a'; // 5 digit string that causes an error
  test('Test Digits Exception  | [$digit5]', () {
    Exception? err;
    try {
      Maidenhead.decode(digit5);
    } on MaidenheadException catch (e) {
      err = e;
    }
    expect(err, isNotNull);
    expect(err, isA<MaidenheadException>());
  });
}
