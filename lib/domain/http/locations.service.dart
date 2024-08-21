import 'package:tractian_mobile_challenge/core/http/dio.service.dart';
import 'package:tractian_mobile_challenge/core/http/dio_base.service.dart';
import 'package:tractian_mobile_challenge/domain/models/location.model.dart';

class LocationsService extends DioService<LocationModel, String> {
  LocationsService({required super.client, required super.path});

  @override
  JsonModelConvert<LocationModel> get converter => JsonModelConvert(fromJson: LocationModel.fromJson);
}
