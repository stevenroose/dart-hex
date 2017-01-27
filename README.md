# dart-hex

Easy hexadecimal encoding and decoding using the dart:convert API.

## Usage

A simple usage example:

```dart
import "package:hex/hex.dart";

void main() {
  HEX.encode(const [1, 2, 3]); // "010203"
  HEX.decode("010203"); // [1, 2, 3]
}
```
