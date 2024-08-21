import 'package:equatable/equatable.dart';

import 'item.entity.dart';
import 'dart:core';

enum SensorType { vibration, energy }

enum Status { operating, alert }

class Asset extends Item with EquatableMixin {
  final String? gatewayId;
  final String? locationId;
  final String? sensorId;
  final SensorType? sensorType;
  final Status? status;

  const Asset({
    required super.id,
    required super.name,
    super.parentId,
    this.gatewayId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  @override
  List<Object?> get props => [...super.props, gatewayId, locationId, sensorId, sensorType, status];
}
