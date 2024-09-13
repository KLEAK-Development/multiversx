import 'dart:convert';
import 'dart:typed_data';

import 'package:multiversx_sdk/src/message/base.dart';
import 'package:pointycastle/export.dart';

final class SignableMessage extends Message {
  SignableMessage(super.bytes);

  factory SignableMessage.fromMessage(final String message) {
    final bytes = utf8.encode(message);
    final messageSize = utf8.encode(message.length.toString());
    final signableMessage = [...messageSize, ...bytes];
    final bytesToHash = [...utf8.encode(messagePrefix), ...signableMessage];

    final digest = KeccakDigest(256).process(Uint8List.fromList(bytesToHash));
    return SignableMessage(digest);
  }
}
