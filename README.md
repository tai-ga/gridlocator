# Maidenhead

[![CI Test](https://github.com/tai-ga/maidenhead/actions/workflows/ci-test.yaml/badge.svg)](https://github.com/tai-ga/maidenhead/actions/workflows/ci-test.yaml)

Maidenhead Locator (grid square) System in Dart.

Based on the algorithm published by Edmund T. Tyson, N5JTY, titled "Conversion Between Geodetic and Grid Locator Systems" in _QST_ January 1989, pp. 29-30, 43.

_Inspired by [go-gridlocator](https://github.com/jasonhancock/go-gridlocator) Go module._

## Maidenhead Locator System?

The [Maidenhead Locator System](https://en.wikipedia.org/wiki/Maidenhead_Locator_System) (a.k.a. QTH Locator and IARU Locator) is a geocode system used by amateur radio operators to succinctly describe their geographic coordinates, which replaced the deprecated QRA locator, which was limited to European contacts.[1] Its purpose is to be concise, accurate, and robust in the face of interference and other adverse transmission conditions. The Maidenhead Locator System can describe locations anywhere in the world.

![Example of Grid System](https://upload.wikimedia.org/wikipedia/commons/1/1d/Maidenhead_grid_over_Europe.svg)

## Usage

Encoding

```dart
import 'package:maidenhead/maidenhead.dart';

const m = Maidenhead(-34.91, -56.211666666666667);
print(m.encode()); // output: GF15vc
```

Decoding

```dart
import 'package:maidenhead/maidenhead.dart';

final m = Maidenhead.decode('GF15vc');
print(m.latitude); // output: -34.916666666666664
print(m.longitude); // output: -56.25
```