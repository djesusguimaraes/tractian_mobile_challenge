import 'package:tractian_mobile_challenge/core/domain/asset.entity.dart';

class AssetModel extends Asset {
  AssetModel({
    required super.id,
    required super.name,
    super.parentId,
    super.gatewayId,
    super.locationId,
    super.sensorId,
    super.sensorType,
    super.status,
  });

  factory AssetModel.fromJson(Map<String, dynamic> json) {
    T? handleEnumEvaluation<T>(String key, T? Function(String?) resolve) {
      if (!json.containsKey(key)) return null;
      return resolve.call(json[key]);
    }

    return AssetModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
      status: handleEnumEvaluation<Status>('status', resolveStatus),
      sensorType: handleEnumEvaluation<SensorType>('sensorType', resolveSensorType),
    );
  }
}

SensorType? resolveSensorType(String? type) {
  if (type == null) return null;
  if (type == 'vibration') return SensorType.vibration;
  if (type == 'energy') return SensorType.energy;
  return null;
}

Status? resolveStatus(String? status) {
  if (status == null) return null;
  if (status == 'operating') return Status.operating;
  if (status == 'alert') return Status.alert;
  return null;
}
