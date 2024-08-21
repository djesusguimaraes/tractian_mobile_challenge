import 'package:tractian_mobile_challenge/core/http/dio.service.dart';
import 'package:tractian_mobile_challenge/core/http/dio_base.service.dart';
import 'package:tractian_mobile_challenge/domain/models/asset.model.dart';

class AssetsService extends DioService<AssetModel, String> {
  AssetsService({required super.client, required super.path});

  @override
  JsonModelConvert<AssetModel> get converter => JsonModelConvert(fromJson: AssetModel.fromJson);
}
