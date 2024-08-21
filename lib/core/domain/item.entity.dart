import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String name;
  final String? parentId;

  const Item({
    required this.id,
    required this.name,
    this.parentId,
  });

  @override
  List<Object?> get props => [id, name, parentId];
}
