import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:pinenacl/ed25519.dart' as pinenacl;

import 'seed.dart';

void main() async {
  final mnemonic1 = Bip44.fromMnemonic(mnemonic: seed);
  print(mnemonic1.entropy);
  print(mnemonic1.mnemonic == seed);

  final key1 = await mnemonic1.deriveKey();
  print(key1);

  final signingKey = await SigningKey.fromMnemonic(mnemonic: seed);
  final publicKey = signingKey.generatePublicKey();
  print(publicKey.bech32 ==
      'erd1qsnaz30h4c6fdn9q752kmjt57zwmgl5qg27r4jswwpj6vt3rsjyqsjck4k');
}
