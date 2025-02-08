import 'dart:typed_data';

import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/nonce.dart';
import 'package:pointycastle/pointycastle.dart' show Digest;

/// Represents the virtual machine type for smart contracts
enum ArwenVirtualMachine {
  v1([0x05, 0x00]);

  final List<int> value;

  const ArwenVirtualMachine(this.value);
}

Uint8List _int32Bytes(int value, {Endian endian = Endian.little}) =>
    Uint8List(8)..buffer.asByteData().setInt32(0, value, endian);

PublicKey computeContractAddress(PublicKey address, Nonce nonce) {
  final bytesToHash = [
    ...address.bytes,
    ..._int32Bytes(nonce.value),
  ];
  final digest =
      Digest('Keccak/256').process(Uint8List.fromList(bytesToHash)).toList();
  final bytes = [
    for (var i = 0; i < 8; i++) 0,
    ...[5, 0],
    ...digest.sublist(10, 30),
    ...address.bytes.sublist(30),
  ];
  return PublicKey(bytes);
}
