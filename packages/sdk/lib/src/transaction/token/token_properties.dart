import 'package:meta/meta.dart';

/// Base class for common token properties
@immutable
abstract base class BaseTokenProperties {
  final bool? canFreeze;
  final bool? canWipe;
  final bool? canPause;
  final bool? canChangeOwner;
  final bool? canUpgrade;
  final bool? canAddSpecialRoles;

  const BaseTokenProperties({
    this.canFreeze,
    this.canWipe,
    this.canPause,
    this.canChangeOwner,
    this.canUpgrade,
    this.canAddSpecialRoles,
  });

  Map<String, bool> toMap() {
    return {
      if (canFreeze != null) 'canFreeze': canFreeze!,
      if (canWipe != null) 'canWipe': canWipe!,
      if (canPause != null) 'canPause': canPause!,
      if (canChangeOwner != null) 'canChangeOwner': canChangeOwner!,
      if (canUpgrade != null) 'canUpgrade': canUpgrade!,
      if (canAddSpecialRoles != null) 'canAddSpecialRoles': canAddSpecialRoles!,
    };
  }
}

/// Properties specific to ESDT tokens
@immutable
final class EsdtTokenProperties extends BaseTokenProperties {
  final bool? canMint;
  final bool? canBurn;

  const EsdtTokenProperties({
    super.canFreeze,
    super.canWipe,
    super.canPause,
    super.canChangeOwner,
    super.canUpgrade,
    super.canAddSpecialRoles,
    this.canMint,
    this.canBurn,
  });

  @override
  Map<String, bool> toMap() {
    return {
      ...super.toMap(),
      if (canMint != null) 'canMint': canMint!,
      if (canBurn != null) 'canBurn': canBurn!,
    };
  }
}

/// Properties specific to NFT tokens
@immutable
final class NftTokenProperties extends BaseTokenProperties {
  final bool? canTransferNFTCreateRole;

  const NftTokenProperties({
    super.canFreeze,
    super.canWipe,
    super.canPause,
    super.canChangeOwner,
    super.canUpgrade,
    super.canAddSpecialRoles,
    this.canTransferNFTCreateRole,
  });

  @override
  Map<String, bool> toMap() {
    return {
      ...super.toMap(),
      if (canTransferNFTCreateRole != null)
        'canTransferNFTCreateRole': canTransferNFTCreateRole!,
    };
  }
}
