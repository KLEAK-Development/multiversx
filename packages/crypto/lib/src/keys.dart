import 'package:multiversx_crypto/src/bip_44.dart';
import 'package:pinenacl/api.dart';
import 'package:pinenacl/ed25519.dart' as ed25519;
import 'package:convert/convert.dart' as convert;

class SigningKey {
  static Future<SigningKey> fromMnemonic(final String mnemonic) async {
    final bip44 = Bip44.fromMnemonic(mnemonic);
    return SigningKey._(
      ed25519.SigningKey.fromSeed(
        Uint8List.fromList(
          await bip44.deriveKey(),
        ),
      ),
    );
  }

  static Future<SigningKey> fromEntropy(final String entropy) async {
    final bip44 = Bip44.fromEntropy(entropy);
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

  PublicKey get publicKey => PublicKey(_signingKey.publicKey);

  List<int> sign(final List<int> data) {
    final signedMessage = _signingKey.sign(Uint8List.fromList(data));
    return signedMessage.signature.toList();
  }
}

final _bech32Encoder = ed25519.Bech32Encoder(hrp: 'erd');
const pubkeyLength = 32;

class PublicKey {
  final List<int> bytes;

  const PublicKey(this.bytes)
      : assert(bytes.length == pubkeyLength,
            'bytes length must be equal to $pubkeyLength but it is ${bytes.length}');

  PublicKey.fromAddress(final PublicKey publicKey) : bytes = publicKey.bytes;

  PublicKey.fromBech32(final String bech32)
      : bytes = _bech32Encoder.decode(bech32);

  PublicKey.fromHex(final String hex) : bytes = convert.hex.decode(hex);

  PublicKey.zero() : bytes = List.generate(32, (_) => 0, growable: false);

  String get hex => convert.hex.encode(bytes);

  String get bech32 => _bech32Encoder.encode(bytes);
}
