import 'item.entity.dart';

class Location extends Item {
  const Location({
    required super.id,
    required super.name,
    super.parentId,
    super.children,
    super.parents,
  });

  @override
  ItemType get type {
    if (parentId == null) return ItemType.location;
    return ItemType.sublocation;
  }

  @override
  Item copyWithGenealogy(Set<String> parents, Set<String> children) => Location(
        id: id,
        name: name,
        parentId: parentId,
        children: children,
        parents: parents,
      );
}
