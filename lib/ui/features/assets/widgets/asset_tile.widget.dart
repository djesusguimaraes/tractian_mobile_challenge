import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';
import 'package:tractian_mobile_challenge/core/utils/app_assets.dart';

class AssetTile extends StatelessWidget {
  const AssetTile({super.key, required this.asset});

  final Item asset;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(asset.name),
      subtitle: Text(asset.children.join(' > ')),
      leading: SizedBox.square(dimension: 22, child: asset.type.icon),
    );
  }
}

extension XItemType on ItemType {
  Widget get icon {
    if (isLocation || isSublocation) return AppAssets.location;
    if (isAsset || isSubasset) return AppAssets.asset;
    return AppAssets.component;
  }
}
