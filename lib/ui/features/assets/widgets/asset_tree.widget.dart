import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:tractian_mobile_challenge/core/domain/asset.entity.dart';
import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';
import 'package:tractian_mobile_challenge/core/utils/app_assets.dart';

class AssetTree extends StatelessWidget {
  final List<Item> items;

  const AssetTree({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final tree = _buildTree();

    return ListView.builder(
      itemCount: tree.length,
      padding: const EdgeInsets.all(10).copyWith(top: 0),
      itemBuilder: (_, index) => ListTileTheme(
        dense: true,
        minLeadingWidth: 20,
        horizontalTitleGap: 4,
        tileColor: Colors.transparent,
        contentPadding: const EdgeInsets.symmetric(horizontal: 4),
        child: tree.elementAt(index),
      ),
    );
  }

  List<Widget> _buildTree() {
    Widget builder(Item item) {
      if (item.children.isEmpty) {
        final tile = ListTile(title: _AssetTitle(item));
        if (item.parents.isNotEmpty) return Padding(padding: const EdgeInsets.only(left: 16.0), child: tile);
        return tile;
      }

      return ExpansionTile(
        dense: true,
        initiallyExpanded: true,
        title: _AssetTitle(item),
        textColor: Colors.black87,
        tilePadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.only(left: 16.0),
        shape: const Border(left: BorderSide(color: Colors.black12)),
        children: item.children.map((id) {
          final child = items.firstWhereOrNull((item) => item.id == id);
          if (child == null) return const SizedBox.shrink();
          return builder(child);
        }).toList(),
      );
    }

    final first = items.where((item) => item.type.onRoot);
    return first.map((item) => builder(item)).toList();
  }
}

class _AssetTitle extends StatelessWidget {
  const _AssetTitle(this.asset);

  final Item asset;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox.square(dimension: 22, child: asset.type.icon),
      Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text(asset.name)),
      if (asset.type.hasTrailingIndicator) ...resolveTrailing()
    ]);
  }

  List<Widget> resolveTrailing() {
    if (this.asset is! Asset) return [];
    final asset = this.asset as Asset;
    return [
      if (asset.sensorType == SensorType.energy) const Icon(Icons.bolt, size: 16, color: Colors.green),
      if (asset.status == Status.alert) const CircleAvatar(backgroundColor: Colors.red, radius: 4),
    ];
  }
}

extension XItemType on ItemType {
  Widget get icon {
    if (isLocation || isSublocation) return AppAssets.location;
    if (isAsset || isSubasset) return AppAssets.asset;
    return AppAssets.component;
  }

  bool get onRoot => isLocation || isUnknown;
  bool get hasTrailingIndicator => isComponent || isUnknown;

  Widget get trailingIndicator {
    if (isComponent) return const Icon(Icons.circle, size: 8, color: Colors.black26);
    return const SizedBox.shrink();
  }
}
