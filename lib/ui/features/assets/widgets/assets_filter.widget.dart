import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:tractian_mobile_challenge/core/domain/asset.entity.dart';
import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';

class AssetsFilter extends StatefulWidget {
  const AssetsFilter({super.key, required this.items, required this.builder});

  final List<Item> items;
  final Widget Function(List<Item>) builder;

  @override
  State<AssetsFilter> createState() => _AssetsFilterState();
}

class _AssetsFilterState extends State<AssetsFilter> {
  String _query = '';
  int? _choice;

  final debounce = Debounce(milliseconds: 1000);

  @override
  void dispose() {
    debounce.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              onChanged: (value) => debounce(() => setState(() => _query = value)),
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Buscar Ativo ou Local'),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: choices.mapIndexed((index, choice) {
                final isSelected = _choice == index;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (value) => setState(() => _choice = value ? index : null),
                  label: Text(choice.$2, style: const TextStyle(fontWeight: FontWeight.w500)),
                  avatar: Icon(choice.$1, color: isSelected ? Colors.white : const Color(0xff77818C)),
                );
              }).toList(),
            ),
          ]),
        ),
        const Divider(height: 0),
        Expanded(
          child: widget.builder.call(filtered..sort((a, b) => a.type.index.compareTo(b.type.index))),
        ),
      ]);

  List<Item> get filtered {
    if (!isFiltering) return widget.items;
    final result = widget.items.where((item) => item.name.toLowerCase().contains(_query.toLowerCase())).where((item) {
      if (_choice != null) {
        if (item is! Asset) return false;
        if (_choice == 0) return item.sensorType == SensorType.energy;
        if (_choice == 1) return item.status == Status.alert;
      }
      return true;
    }).toList();

    final parentIds = result.map((res) => res.parents).flattened.toSet();
    final parents = parentIds.map((id) => widget.items.firstWhere((item) => item.id == id));

    return {...result, ...parents}.toList();
  }

  bool get isFiltering => _query.isNotEmpty || _choice != null;

  List<(IconData, String)> get choices => [
        (Icons.bolt_outlined, 'Sensor de Energia'),
        (Icons.error_outline, 'Crítico'),
      ];
}

class Debounce {
  Debounce({required this.milliseconds});

  final int milliseconds;
  Timer? timer;

  void call(VoidCallback callback) {
    cancel();
    timer = Timer(Duration(milliseconds: milliseconds), callback);
  }

  void cancel() {
    if (timer?.isActive ?? false) timer!.cancel();
  }
}
