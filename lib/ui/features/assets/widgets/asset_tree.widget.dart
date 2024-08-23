import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:tractian_mobile_challenge/core/domain/asset.entity.dart';
import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';
import 'package:tractian_mobile_challenge/core/utils/app_assets.dart';
import 'package:tractian_mobile_challenge/ui/widgets/future_retry_builder.widget.dart';

class AssetTree extends StatelessWidget {
  final List<Item> items;

  const AssetTree({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const Padding(padding: EdgeInsets.all(20), child: Text('Sua pesquisa não gerou resultados'));

    return ListTileTheme(
      dense: true,
      minLeadingWidth: 20,
      horizontalTitleGap: 4,
      tileColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      child: FutureRetryBuilder(
        future: compute(_buildTree, items),
        builder: (tree) => _InfiniteTree(children: tree),
      ),
    );
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

List<Widget> _buildTree(List<Item> items) {
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
  return first.map(builder).toList();
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

class _InfiniteTree extends StatefulWidget {
  const _InfiniteTree({required this.children});

  final List<Widget> children;

  @override
  State<_InfiniteTree> createState() => _InfiniteTreeState();
}

class _InfiniteTreeState extends State<_InfiniteTree> {
  int get _pageSize => 10;

  final PagingController<int, Widget> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener(_fetchPage);
    super.initState();
  }

  List<Widget> paginateTree(int key, int size) {
    final fim = key + size;
    final tree = widget.children;
    return tree.sublist(key, fim > tree.length ? tree.length : fim);
  }

  void _fetchPage(int pageKey) {
    try {
      final newItems = paginateTree(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) return _pagingController.appendLastPage(newItems);
      _pagingController.appendPage(newItems, pageKey + newItems.length);
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PagedListView<int, Widget>(
        cacheExtent: 500,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Widget>(itemBuilder: (_, item, __) => item),
      );
}
