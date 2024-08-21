import 'package:tractian_mobile_challenge/core/domain/location.entity.dart';

class LocationModel extends Location {
  const LocationModel({required super.id, required super.name, super.parentId});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
