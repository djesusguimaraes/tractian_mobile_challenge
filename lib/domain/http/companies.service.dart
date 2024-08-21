import 'package:tractian_mobile_challenge/core/http/dio.service.dart';
import 'package:tractian_mobile_challenge/core/http/dio_base.service.dart';
import 'package:tractian_mobile_challenge/domain/models/company.model.dart';

class CompaniesService extends DioService<CompanyModel, String> {
  CompaniesService({required super.client, required super.path});

  @override
  JsonModelConvert<CompanyModel> get converter => JsonModelConvert(fromJson: CompanyModel.fromJson);
}
