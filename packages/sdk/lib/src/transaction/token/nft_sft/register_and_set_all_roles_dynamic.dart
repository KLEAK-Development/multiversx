import 'package:meta/meta.dart';
import 'package:multiversx_crypto/multiversx_crypto.dart';
import 'package:multiversx_sdk/src/balance.dart';
import 'package:multiversx_sdk/src/network_parameters.dart';
import 'package:multiversx_sdk/src/transaction/base.dart';
import 'package:multiversx_sdk/src/transaction/custom.dart';
import 'package:multiversx_sdk/src/transaction/token/dynamic_token.dart';

/// A transaction class used to register a dynamic token and set all roles
/// on the MultiversX blockchain.
///
/// This transaction:
/// - Registers a new dynamic token
/// - Sets all available roles for the specific token type
/// - Requires a fee of 0.05 EGLD
/// - Has a base gas limit of 60,000,000 units
/// - Requires the sender to be the token manager
@immutable
final class RegisterAndSetAllRolesDynamicTransaction
    extends TransactionWithData {
  /// Creates a new transaction to register a dynamic token with all roles.
  ///
  /// Parameters:
  /// - [networkConfiguration]: The network configuration for the transaction
  /// - [nonce]: The nonce of the token manager's account
  /// - [sender]: The address of the token manager
  /// - [tokenName]: The name of the token to register
  /// - [tokenTicker]: The ticker symbol for the token
  /// - [tokenType]: The type of dynamic token (NFT, SFT, or META)
  /// - [numDecimals]: The number of decimals (required only for META tokens)
  /// - [gasLimit]: Additional gas limit to add to the base gas limit of 60,000,000
  ///
  /// Throws an [AssertionError] if:
  /// - numDecimals is missing for META tokens
  /// - numDecimals is provided for non-META tokens
  RegisterAndSetAllRolesDynamicTransaction({
    required super.networkConfiguration,
    required super.nonce,
    required super.sender,
    required String tokenName,
    required String tokenTicker,
    required DynamicTokenType tokenType,
    int? numDecimals,
    GasLimit gasLimit = const GasLimit(0),
  })  : assert(
          tokenType != DynamicTokenType.meta || numDecimals != null,
          'Number of decimals is required for META tokens',
        ),
        assert(
          tokenType == DynamicTokenType.meta || numDecimals == null,
          'Number of decimals is only applicable for META tokens',
        ),
        super(
          receiver: PublicKey.fromBech32(
            'erd1qqqqqqqqqqqqqqqpqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqzllls8a5w6u',
          ),
          gasLimit: gasLimit + const GasLimit(60000000),
          value: Balance.fromEgld(0.05),
          data: RegisterAndSetAllRolesDynamicTransactionData(
            tokenName: tokenName,
            tokenTicker: tokenTicker,
            tokenType: tokenType,
            numDecimals: numDecimals,
          ),
        );
}

/// Transaction data class specifically for registering dynamic tokens with all roles.
///
/// This class handles the formatting of the registration data into
/// the required transaction data format, including the command and all
/// necessary arguments.
@immutable
final class RegisterAndSetAllRolesDynamicTransactionData
    extends CustomTransactionData {
  /// Creates transaction data for registering a dynamic token with all roles.
  ///
  /// Parameters:
  /// - [tokenName]: The name of the token to register
  /// - [tokenTicker]: The ticker symbol for the token
  /// - [tokenType]: The type of dynamic token (NFT, SFT, or META)
  /// - [numDecimals]: The number of decimals (required only for META tokens)
  factory RegisterAndSetAllRolesDynamicTransactionData({
    required String tokenName,
    required String tokenTicker,
    required DynamicTokenType tokenType,
    int? numDecimals,
  }) {
    final arguments = [
      tokenName,
      tokenTicker,
      tokenType.value,
      if (tokenType == DynamicTokenType.meta && numDecimals != null)
        numDecimals,
    ];

    return RegisterAndSetAllRolesDynamicTransactionData._(
      command: 'registerAndSetAllRolesDynamic',
      arguments: arguments,
    );
  }

  /// Private constructor for [RegisterAndSetAllRolesDynamicTransactionData].
  RegisterAndSetAllRolesDynamicTransactionData._({
    required super.command,
    super.arguments,
  });
}
