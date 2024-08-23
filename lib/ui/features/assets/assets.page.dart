import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';
import 'package:tractian_mobile_challenge/domain/http/assets.service.dart';
import 'package:tractian_mobile_challenge/domain/http/locations.service.dart';
import 'package:tractian_mobile_challenge/ui/features/assets/widgets/asset_tree.widget.dart';
import 'package:tractian_mobile_challenge/ui/widgets/future_retry_builder.widget.dart';

import 'widgets/assets_filter.widget.dart';

final getIt = GetIt.instance;

class AssetsPage extends StatelessWidget {
  static const route = '/assets';

  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final companyId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Assets')),
      body: FutureRetryBuilder(
        future: _getItems(companyId),
        builder: (data) => AssetsFilter(items: data, builder: (items) => AssetTree(items: items)),
      ),
    );
  }
}

Future<List<Item>> _getItems(String companyId) async {
  final data = await Future.wait([
    getIt<LocationsService>(param1: companyId).getAll(),
    getIt<AssetsService>(param1: companyId).getAll(),
  ]).then((res) => [...res.first, ...res.last]);
  return await compute(buildItemsGenealogy, data);
}

List<Item> buildItemsGenealogy(List<Item> items) {
  /// Create a map with the relations between items, {child: parent}
  final relations = {for (final item in items) item.id: item.parentId ?? item.locationId};

  /// Select only the parents of the items in [relations]
  final parents = relations.values.whereNotNull().toSet();

  /// Create a map with the relations between parents and children, {parent: children}
  inversion(String parent) => relations.entries.where((e) => e.value == parent).map((e) => e.key).toSet();
  final inverse = {for (final parent in parents) parent: inversion(parent)};

  /// Find all ancestors of each item and store them in a map, {item: ancestors}
  Map<String, Set<String>> ancestors = {};
  for (final relation in relations.entries.where((e) => e.value != null).toList()) {
    ancestors[relation.key] = findAllParents(relations, relation.key);
  }

  return items.map((item) => item.copyWithGenealogy(ancestors[item.id] ?? {}, inverse[item.id] ?? {})).toList();
}

Set<String> findAllParents(Map<String, String?> relations, String id, {Set<String> parents = const {}}) {
  final parentId = relations[id];
  if (parentId == null) return parents;
  return findAllParents(relations, parentId, parents: {parentId, ...parents});
}
