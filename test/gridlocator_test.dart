import 'package:flutter_test/flutter_test.dart';
import 'package:gridlocator/gridlocator.dart';

class _T {
  const _T(this.gridlocator, this.latitude, this.longitude);
  final String gridlocator;
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
    test('Test Gridlocator Encode | [${t.gridlocator}]', () {
      expect(
        Gridlocator(t.latitude, t.longitude).encode(),
        t.gridlocator,
      );
    });

    test('Test Gridlocator Decode | [${t.gridlocator}]', () {
      expect(
        Gridlocator.decode(t.gridlocator).latitude,
        closeTo(t.latitude, .1),
      );
      expect(
        Gridlocator.decode(t.gridlocator).longitude,
        closeTo(t.longitude, .1),
      );
    });
  });

  const digit5 = 'JJ00a'; // 5 digit string that causes an error
  test('Test Digits Exception  | [$digit5]', () {
    Exception? err;
    try {
      Gridlocator.decode(digit5);
    } on GridlocatorException catch (e) {
      err = e;
    }
    expect(err, isNotNull);
    expect(err, isA<GridlocatorException>());
  });
}
