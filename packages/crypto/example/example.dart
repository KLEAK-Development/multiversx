import 'package:multiversx_crypto/multiversx_crypto.dart';

import 'mnemonic.dart';

void main() async {
  final mnemonic1 = Bip44.fromMnemonic(mnemonic);
  print(mnemonic1.entropy);
  print(mnemonic1.mnemonic == mnemonic);

  final key1 = await mnemonic1.deriveKey();
  print(key1);

  final signingKey = await SigningKey.fromMnemonic(mnemonic);
  final publicKey = signingKey.publicKey;
  print(publicKey.bech32 ==
      'erd1qsnaz30h4c6fdn9q752kmjt57zwmgl5qg27r4jswwpj6vt3rsjyqsjck4k');
}
