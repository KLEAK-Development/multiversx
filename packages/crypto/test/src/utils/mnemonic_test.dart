import 'package:test/test.dart';
import 'package:multiversx_crypto/src/utils/mnemonic.dart';

void main() {
  group('ValidMnemonic extension', () {
    test('isValid returns true for a valid mnemonic', () {
      const validMnemonic =
          'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about';
      expect(validMnemonic.isValid(), isTrue);
    });

    test('isValid returns false for an invalid mnemonic', () {
      const invalidMnemonic = 'invalid mnemonic phrase';
      expect(invalidMnemonic.isValid(), isFalse);
    });

    test('isValid returns false for an empty string', () {
      const emptyMnemonic = '';
      expect(emptyMnemonic.isValid(), isFalse);
    });

    test('isValid returns false for a mnemonic with incorrect word count', () {
      const shortMnemonic = 'abandon abandon abandon';
      expect(shortMnemonic.isValid(), isFalse);
    });
  });
}
