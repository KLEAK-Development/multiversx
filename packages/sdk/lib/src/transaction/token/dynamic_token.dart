/// Represents the type of dynamic token to register.
enum DynamicTokenType {
  /// Non-Fungible Token type
  nft('NFT'),

  /// Semi-Fungible Token type
  sft('SFT'),

  /// Meta Token type
  meta('META');

  final String value;
  const DynamicTokenType(this.value);
}
