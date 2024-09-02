import 'package:multiversx_crypto/src/bip_44.dart';
import 'package:multiversx_crypto/src/utils/mnemonic.dart';
import 'package:test/test.dart';

void main() {
  group('Bip44', () {
    test('generate creates a valid Bip44 instance', () {
      final bip44 = Bip44.generate();
      expect(bip44, isA<Bip44>());
      expect(bip44.mnemonic.isValid(), isTrue);
    });

    test('fromMnemonic creates a valid Bip44 instance', () {
      const validMnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      final bip44 = Bip44.fromMnemonic(validMnemonic);
      expect(bip44, isA<Bip44>());
      expect(bip44.mnemonic, equals(validMnemonic));
    });

    test('fromEntropy creates a valid Bip44 instance', () {
      const validEntropy = '00000000000000000000000000000000';
      final bip44 = Bip44.fromEntropy(validEntropy);
      expect(bip44, isA<Bip44>());
      expect(bip44.entropy, equals(validEntropy));
    });

    test('deriveKey generates correct key', () async {
      const mnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      final bip44 = Bip44.fromMnemonic(mnemonic);
      final derivedKey = await bip44.deriveKey();

      // This expected value should be replaced with the actual expected key for the given mnemonic
      final expectedKey = [
        14,
        184,
        157,
        129,
        109,
        104,
        97,
        6,
        131,
        242,
        9,
        7,
        74,
        242,
        24,
        209,
        33,
        167,
        199,
        219,
        69,
        216,
        97,
        251,
        221,
        149,
        158,
        198,
        98,
        182,
        64,
        75
      ];
      expect(derivedKey, equals(expectedKey));
    });

    test('deriveKey with custom address index', () async {
      final bip44 = Bip44.generate();
      final key0 = await bip44.deriveKey(addressIndex: 0);
      final key1 = await bip44.deriveKey(addressIndex: 1);
      expect(key0, isNot(equals(key1)));
    });

    test('deriveKey with password', () async {
      final bip44 = Bip44.generate();
      final keyWithoutPassword = await bip44.deriveKey();
      final keyWithPassword = await bip44.deriveKey(password: 'mypassword');
      expect(keyWithoutPassword, isNot(equals(keyWithPassword)));
    });

    test('throws assertion error for invalid mnemonic', () {
      expect(() => Bip44.fromMnemonic('invalid mnemonic'),
          throwsA(isA<AssertionError>()));
    });
  });
}
