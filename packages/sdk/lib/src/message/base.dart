const messagePrefix = '\x17Elrond Signed Message:\n';

class Message {
  final List<int> bytes;

  Message(this.bytes);
}
