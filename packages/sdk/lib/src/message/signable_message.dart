import 'dart:convert';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:multiversx_sdk/src/message/base.dart';
import 'package:pointycastle/export.dart';

/// Represents a message that can be signed in the MultiversX ecosystem.
///
/// This class extends [Message] and provides functionality to create a signable
/// message from a string input.
@immutable
final class SignableMessage extends Message {
  /// Creates a new [SignableMessage] instance.
  ///
  /// [bytes] is a list of integers representing the raw byte content of the message.
  const SignableMessage(super.bytes);

  /// Creates a [SignableMessage] from a string message.
  ///
  /// This factory method performs the following steps:
  /// 1. Encodes the input message to UTF-8 bytes.
  /// 2. Prepends the message size to the encoded message.
  /// 3. Prepends the [messagePrefix] to create the full signable message.
  /// 4. Hashes the resulting bytes using Keccak-256.
  ///
  /// [message] is the string message to be converted into a signable message.
  ///
  /// Returns a new [SignableMessage] instance containing the Keccak-256 digest
  /// of the prepared message.
  factory SignableMessage.fromMessage(final String message) {
    final bytes = utf8.encode(message);
    final messageSize = utf8.encode(message.length.toString());
    final signableMessage = [...messageSize, ...bytes];
    final bytesToHash = [...utf8.encode(messagePrefix), ...signableMessage];

    final digest = KeccakDigest(256).process(Uint8List.fromList(bytesToHash));
    return SignableMessage(digest);
  }
}
