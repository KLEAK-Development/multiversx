import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:bip39/bip39.dart';

const mnemonicStrength = 256;
const bip44DerivationPrefix = "m/44'/508'/0'/0'";

class Bip44 {
  final String entropy;

  const Bip44._(this.entropy);

  factory Bip44.fromEntropy(String entropy) {
    final mnemonic = entropyToMnemonic(entropy);
    assert(validateMnemonic(mnemonic), 'mnemonic is not valid');
    return Bip44._(entropy);
  }

  factory Bip44.fromMnemonic(final String mnemonic) {
    assert(validateMnemonic(mnemonic), 'mnemonic is not valid');
    return Bip44._(mnemonicToEntropy(mnemonic.trim()));
  }

  factory Bip44.generate() {
    final mnemonic = generateMnemonic(strength: mnemonicStrength);
    return Bip44.fromMnemonic(mnemonic);
  }

  Future<List<int>> deriveKey({
    final int addressIndex = 0,
    final String password = '',
  }) async {
    final seed =
        mnemonicToSeed(entropyToMnemonic(entropy), passphrase: password);
    final data = await ED25519_HD_KEY.derivePath(
        "$bip44DerivationPrefix/$addressIndex'", seed);
    return data.key;
  }

  String get mnemonic => entropyToMnemonic(entropy);
}
