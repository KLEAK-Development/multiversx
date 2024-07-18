import 'dart:typed_data';

import 'package:multiversx_crypto/src/bip_44.dart';
import 'package:pinenacl/ed25519.dart' as ed25519;
import 'package:convert/convert.dart' as convert;

class SigningKey {
  static Future<SigningKey> fromMnemonic({
    required final String mnemonic,
  }) async {
    final bip44 = Bip44.fromMnemonic(mnemonic: mnemonic);
    return SigningKey._(
      ed25519.SigningKey.fromSeed(
        Uint8List.fromList(
          await bip44.deriveKey(),
        ),
      ),
    );
  }

  final ed25519.SigningKey _signingKey;

  SigningKey._(this._signingKey);

  SigningKey.fromValidKey({required final Uint8List bytes})
      : _signingKey = ed25519.SigningKey.fromValidBytes(bytes);

  List<int> get bytes => _signingKey.toList();

  PublicKey generatePublicKey() {
    return PublicKey(_signingKey.publicKey);
  }

  List<int> sign(final List<int> data) {
    final signedMessage = _signingKey.sign(Uint8List.fromList(data));
    return signedMessage.signature.toList();
  }
}

extension type PublicKey(List<int> bytes) {
  String get hex => convert.hex.encode(bytes);
}
