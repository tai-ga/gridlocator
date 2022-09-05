import 'package:gridlocator/gridlocator.dart';

void main() {
  const m = Gridlocator(-34.91, -56.211666666666667);
  final m2 = Gridlocator.decode('GF15vc');

  // ignore: avoid_print
  print('GridLocator: ${m.encode()}');
  // ignore: avoid_print
  print('lat,lng: ${m2.latitude}, ${m2.longitude}');
}
