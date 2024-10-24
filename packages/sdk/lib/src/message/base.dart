import 'package:meta/meta.dart';

/// A constant string used as a prefix for signed messages.
/// This prefix is used to prevent potential attacks by ensuring the
/// message is intended for the Elrond network.
const messagePrefix = '\x17Elrond Signed Message:\n';

/// Represents a message in the MultiversX ecosystem.
///
/// This class is immutable and holds the raw bytes of a message.
@immutable
class Message {
  /// The raw bytes of the message.
  final List<int> bytes;

  /// Creates a new [Message] instance.
  ///
  /// [bytes] is a list of integers representing the raw byte content of the message.
  const Message(this.bytes);
}
