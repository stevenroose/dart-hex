library hex;

import "dart:convert";
import "dart:typed_data";

const String _ALPHABET = "0123456789abcdef";

/// An instance of the default implementation of the [HexCodec].
const HEX = const HexCodec();

/// A codec for encoding and decoding byte arrays to and from
/// hexadecimal strings.
class HexCodec extends Codec<List<int>, String> {

  const HexCodec();

  @override
  Converter<List<int>, String> get encoder => const HexEncoder();

  @override
  Converter<String, List<int>> get decoder => new HexDecoder();

}

/// A converter to encode byte arrays into hexadecimal strings.
class HexEncoder extends Converter<List<int>, String> {

  /// If true, the encoder will encode into uppercase hexadecimal strings.
  final bool upperCase;

  const HexEncoder({bool this.upperCase: false});

  @override
  String convert(List<int> bytes) {
    StringBuffer buffer = new StringBuffer();
    for (int part in bytes) {
      buffer.write('${part < 16 ? '0' : ''}${part.toRadixString(16)}');
    }
    if(upperCase) {
      return buffer.toString().toUpperCase();
    } else {
      return buffer.toString();
    }
  }
}

/// A converter to decode hexadecimal strings into byte arrays.
class HexDecoder extends Converter<String, List<int>> {

  const HexDecoder();

  @override
  List<int> convert(String hex) {
    hex = hex.replaceAll(" ", "");
    hex = hex.toLowerCase();
    if(hex.length % 2 != 0) {
      hex = "0" + hex;
    }
    Uint8List result = new Uint8List(hex.length ~/ 2);
    for(int i = 0 ; i < result.length ; i++) {
      int value = (_ALPHABET.indexOf(hex[i*2]) << 4) //= byte[0] * 16
          + _ALPHABET.indexOf(hex[i*2+1]);
      result[i] = value;
    }
    return result;
  }
}