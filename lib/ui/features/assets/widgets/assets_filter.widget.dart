import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';

class AssetsFilter extends StatefulWidget {
  const AssetsFilter({super.key, required this.items, required this.builder});

  final List<Item> items;
  final Widget Function(List<Item>) builder;

  @override
  State<AssetsFilter> createState() => _AssetsFilterState();
}

class _AssetsFilterState extends State<AssetsFilter> {
  final _controller = TextEditingController();

  int? _choice;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: _controller,
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
        const Divider(),
        Expanded(child: widget.builder.call([])),
      ]);

  List<(IconData, String)> get choices => [
        (Icons.bolt_outlined, 'Sensor de Energia'),
        (Icons.error_outline, 'Crítico'),
      ];
}
