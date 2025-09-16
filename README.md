# Gridlocator

[![CI Test](https://github.com/tai-ga/gridlocator/actions/workflows/ci-test.yaml/badge.svg)](https://github.com/tai-ga/gridlocator/actions/workflows/ci-test.yaml)
[![codecov](https://codecov.io/gh/tai-ga/gridlocator/branch/main/graph/badge.svg?token=5MWX6PWJ8M)](https://codecov.io/gh/tai-ga/gridlocator)
[![pub package](https://img.shields.io/pub/v/gridlocator.svg)](https://pub.dev/packages/gridlocator)
[![Dart SDK](https://img.shields.io/badge/Dart-%3E%3D3.1.1-blue)](https://dart.dev)

A lightweight, pure Dart library for converting between geographic coordinates (latitude/longitude) and Maidenhead grid locators. Perfect for amateur radio applications, geographic data processing, and location-based services.

![Example of Grid System](https://upload.wikimedia.org/wikipedia/commons/1/1d/Maidenhead_grid_over_Europe.svg)

## Features

- 🎯 **Bidirectional conversion** between lat/lon and grid locators
- 🚀 **Pure Dart implementation** - works with both Dart and Flutter projects
- 📐 **High precision** calculations based on the official algorithm
- 🛡️ **Type-safe** with built-in error handling
- 📦 **Zero dependencies** (except for testing)
- ✅ **Well tested** with comprehensive test coverage

## Installation

Add `gridlocator` to your `pubspec.yaml`:

```yaml
dependencies:
  gridlocator: ^0.0.5
```

Then run:

```bash
dart pub get
```

## Usage

### Basic Example

```dart
import 'package:gridlocator/gridlocator.dart';

void main() {
  // Encode coordinates to grid locator
  const location = Gridlocator(35.6762, 139.6503); // Tokyo, Japan
  print(location.encode()); // Output: PM95ur

  // Decode grid locator to coordinates
  final decoded = Gridlocator.decode('PM95ur');
  print('Latitude: ${decoded.latitude}');   // ~35.68
  print('Longitude: ${decoded.longitude}');  // ~139.65
}
```

### Real-World Examples

```dart
// Famous locations
const tokyo = Gridlocator(35.6762, 139.6503);
print('Tokyo: ${tokyo.encode()}');           // PM95ur

const newYork = Gridlocator(40.7128, -74.0060);
print('New York: ${newYork.encode()}');      // FN20xr

const london = Gridlocator(51.5074, -0.1278);
print('London: ${london.encode()}');         // IO91wm

// Decode and get location bounds
final grid = Gridlocator.decode('JN58td');  // Munich, Germany
print('Center: ${grid.latitude}, ${grid.longitude}');
```

### Error Handling

```dart
try {
  final result = Gridlocator.decode('INVALID');
} on GridlocatorException catch (e) {
  print('Error: ${e.message}');
}
```

## Grid System Structure

The Maidenhead Locator System divides the Earth into a hierarchical grid:

| Level | Name | Format | Coverage | Precision |
|-------|------|--------|----------|-----------|
| 1-2 | Field | AA | 20° × 10° | ~1000 km |
| 3-4 | Square | 00 | 2° × 1° | ~100 km |
| 5-6 | Subsquare | aa | 5' × 2.5' | ~10 km |

Example: `JN58td`
- `JN` - Field (Europe)
- `58` - Square (Southern Germany)
- `td` - Subsquare (Munich area)

## API Reference

### `Gridlocator` Class

#### Constructor
```dart
const Gridlocator(double latitude, double longitude)
```
Creates a new Gridlocator instance with the given coordinates.

#### Methods

##### `encode()`
```dart
String encode()
```
Converts the coordinates to a 6-character Maidenhead grid locator string.

##### `decode(String gridlocator)`
```dart
static Gridlocator decode(String gridlocator)
```
Decodes a Maidenhead grid locator string to coordinates. Throws `GridlocatorException` if the input is invalid.

## About Maidenhead Locator System

The [Maidenhead Locator System](https://en.wikipedia.org/wiki/Maidenhead_Locator_System) (also known as QTH Locator or IARU Locator) is a geocode system used by amateur radio operators to succinctly describe their geographic coordinates. It replaced the deprecated QRA locator system and is designed to be:

- **Concise**: Only 6 characters for ~10km precision
- **Robust**: Easily transmitted over radio with minimal errors
- **Global**: Covers the entire Earth

This implementation is based on the algorithm published by Edmund T. Tyson, N5JTY, in "Conversion Between Geodetic and Grid Locator Systems" (_QST_ January 1989, pp. 29-30, 43).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Development

```bash
# Get dependencies
dart pub get

# Run tests
dart test

# Run tests with coverage
dart test --coverage=coverage

# Analyze code
dart analyze
```

## Credits

- Algorithm: Edmund T. Tyson, N5JTY
- Inspired by: [go-gridlocator](https://github.com/jasonhancock/go-gridlocator)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
