import 'dart:core';
import 'package:equatable/equatable.dart';

import 'item.entity.dart';

enum SensorType { vibration, energy }

enum Status { operating, alert }

class Asset extends Item with EquatableMixin {
  final String? gatewayId;
  final String? sensorId;
  final SensorType? sensorType;
  final Status? status;

  const Asset({
    required super.id,
    required super.name,
    super.locationId,
    super.parentId,
    super.children,
    super.parents,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  @override
  List<Object?> get props => [...super.props, gatewayId, sensorId, sensorType, status];

  @override
  ItemType get type {
    final hasNoSensor = sensorId == null && sensorType == null;
    final hasLocation = locationId != null;
    final hasParent = parentId != null;

    if (hasNoSensor) {
      if (hasLocation) return ItemType.asset;
      if (hasParent) return ItemType.subasset;
    }
    if (hasLocation || hasParent) return ItemType.component;
    return ItemType.unknown;
  }

  @override
  Item copyWithGenealogy(Set<String> parents, Set<String> children) => Asset(
        id: id,
        name: name,
        parentId: parentId,
        status: status,
        sensorId: sensorId,
        sensorType: sensorType,
        gatewayId: gatewayId,
        locationId: locationId,
        children: children,
        parents: parents,
      );
}
