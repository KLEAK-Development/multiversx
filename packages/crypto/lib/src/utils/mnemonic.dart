import 'package:bip39/bip39.dart';

typedef Mnemonic = String;

extension ValidMnemonic on String {
  bool isValid() => validateMnemonic(this);
}
