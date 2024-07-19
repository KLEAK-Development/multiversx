import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/nonce.dart';

class Account {
  final PublicKey address;
  final Nonce nonce;
  final Balance balance;
  final String username;

  const Account({
    required this.address,
    required this.nonce,
    required this.balance,
    required this.username,
  });

  Account.withAddress(this.address)
      : nonce = Nonce(0),
        balance = Balance.zero(),
        username = '';

  Account copyWith({
    Nonce? newNonce,
    Balance? newBalance,
    String? newUsername,
  }) =>
      Account(
        address: address,
        nonce: newNonce ?? nonce,
        balance: newBalance ?? balance,
        username: newUsername ?? username,
      );

  Account incementNonce() => copyWith(newNonce: nonce.increment());

  @override
  String toString() =>
      'Account{${address.bech32}, ${balance.value}, ${nonce.value}, $username}';
}
