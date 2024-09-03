import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/nonce.dart';

/// Represents an account in the MultiversX blockchain.
///
/// An [Account] contains information about the account's address, nonce,
/// balance, and username.
class Account {
  /// The public key address of the account.
  final PublicKey address;

  /// The current nonce of the account.
  final Nonce nonce;

  /// The current balance of the account.
  final Balance balance;

  /// The username associated with the account.
  final String username;

  /// Creates an [Account] with the specified properties.
  const Account({
    required this.address,
    required this.nonce,
    required this.balance,
    required this.username,
  });

  /// Creates an [Account] with only the address specified.
  ///
  /// The nonce is initialized to 0, balance to zero, and username to an empty string.
  Account.withAddress(this.address)
      : nonce = Nonce(0),
        balance = Balance.zero(),
        username = '';

  /// Creates a copy of this [Account] with optional new values.
  ///
  /// If a parameter is null, the current value is used.
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

  /// Increments the nonce of the account and returns a new [Account] instance.
  Account incementNonce() => copyWith(newNonce: nonce.increment());

  @override
  String toString() =>
      'Account{${address.bech32}, ${balance.value}, ${nonce.value}, $username}';
}
