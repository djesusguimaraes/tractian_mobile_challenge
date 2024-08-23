import 'package:tractian_mobile_challenge/core/domain/item.entity.dart';

class Company extends Item {
  const Company({required super.id, required super.name});

  @override
  ItemType get type => throw UnimplementedError();

  @override
  Item copyWithGenealogy(Set<String> parents, Set<String> children) => throw UnimplementedError();
}
