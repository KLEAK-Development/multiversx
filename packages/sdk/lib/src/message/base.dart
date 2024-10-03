import 'package:meta/meta.dart';

const messagePrefix = '\x17Elrond Signed Message:\n';

@immutable
class Message {
  final List<int> bytes;

  const Message(this.bytes);
}
