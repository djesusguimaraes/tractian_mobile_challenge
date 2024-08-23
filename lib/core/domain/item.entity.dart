import 'package:equatable/equatable.dart';

enum ItemType {
  location,
  sublocation,
  asset,
  subasset,
  component,
  unknown;

  bool get isLocation => this == ItemType.location;
  bool get isSublocation => this == ItemType.sublocation;
  bool get isAsset => this == ItemType.asset;
  bool get isSubasset => this == ItemType.subasset;
  bool get isComponent => this == ItemType.component;
  bool get isUnknown => this == ItemType.unknown;
}

abstract class Item extends Equatable {
  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final Set<String> children;
  final Set<String> parents;

  const Item({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.children = const {},
    this.parents = const {},
  });

  ItemType get type;

  Item copyWithGenealogy(Set<String> parents, Set<String> children);

  @override
  List<Object?> get props => [id, name, locationId, parentId, children, parents];
}
