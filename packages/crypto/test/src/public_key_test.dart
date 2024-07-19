import 'package:convert/convert.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:test/test.dart';

void main() {
  test('invalid', () async {
    expect(() => PublicKey([0]), throwsA(isA<AssertionError>()));
  });

  test('address.zero', () async {
    final address = PublicKey.zero();
    expect(
        address.bech32,
        equals(
            'erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu'));
  });

  test('address.fromAddress', () async {
    final address = PublicKey.zero();
    final newAddress = PublicKey.fromAddress(address);
    expect(
        newAddress.bech32,
        equals(
            'erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu'));
  });

  test('address.fromHex', () async {
    final address = PublicKey.fromHex(
        '0000000000000000000000000000000000000000000000000000000000000000');
    expect(
        address.bech32,
        equals(
            'erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu'));
  });

  test('address.fromBech32', () async {
    final address = PublicKey.fromBech32(
        'erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu');
    expect(hex.encode(address.bytes),
        '0000000000000000000000000000000000000000000000000000000000000000');
  });

  test('address.fromBech32 wrong hrp', () async {
    expect(
        () => PublicKey.fromBech32(
            'btc1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu'),
        throwsA(isA<AssertionError>()));
  });

  test('toString', () async {
    final address = PublicKey.fromBech32(
        'erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu');
    expect(address.toString(),
        'Address{ erd1qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq6gq4hu }');
  });
}
