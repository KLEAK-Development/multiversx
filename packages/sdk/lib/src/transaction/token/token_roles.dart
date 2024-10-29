/// Contains all possible ESDT token roles
enum EsdtTokenRole {
  /// Allows burning tokens locally
  localBurn('ESDTRoleLocalBurn'),

  /// Allows minting new tokens locally
  localMint('ESDTRoleLocalMint'),

  /// Restricts transfers to addresses with this role
  transfer('ESDTTransferRole');

  final String value;
  const EsdtTokenRole(this.value);
}

/// Contains all possible NFT token roles
enum NftTokenRole {
  /// Allows creating new NFTs
  create('ESDTRoleNFTCreate'),

  /// Allows burning NFTs
  burn('ESDTRoleNFTBurn'),

  /// Allows updating NFT attributes
  updateAttributes('ESDTRoleNFTUpdateAttributes'),

  /// Allows adding URIs to NFTs
  addUri('ESDTRoleNFTAddURI'),

  /// Restricts transfers to addresses with this role
  transfer('ESDTTransferRole'),

  /// Allows updating NFT metadata
  update('ESDTRoleNFTUpdate'),

  /// Allows modifying NFT royalties
  modifyRoyalties('ESDTRoleModifyRoyalties'),

  /// Allows setting new URIs for NFTs
  setNewUri('ESDTRoleSetNewURI'),

  /// Allows modifying the NFT creator
  modifyCreator('ESDTRoleModifyCreator'),

  /// Allows recreating NFTs with new attributes
  recreate('ESDTRoleNFTRecreate');

  final String value;
  const NftTokenRole(this.value);
}

/// Contains all possible SFT token roles
enum SftTokenRole {
  /// Allows creating new SFTs
  create('ESDTRoleNFTCreate'),

  /// Allows burning SFT quantities
  burn('ESDTRoleNFTBurn'),

  /// Allows adding quantity to existing SFTs
  addQuantity('ESDTRoleNFTAddQuantity'),

  /// Restricts transfers to addresses with this role
  transfer('ESDTTransferRole'),

  /// Allows updating SFT metadata
  update('ESDTRoleNFTUpdate'),

  /// Allows modifying SFT royalties
  modifyRoyalties('ESDTRoleModifyRoyalties'),

  /// Allows setting new URIs for SFTs
  setNewUri('ESDTRoleSetNewURI'),

  /// Allows modifying the SFT creator
  modifyCreator('ESDTRoleModifyCreator'),

  /// Allows recreating SFTs with new attributes
  recreate('ESDTRoleNFTRecreate');

  final String value;
  const SftTokenRole(this.value);
}
