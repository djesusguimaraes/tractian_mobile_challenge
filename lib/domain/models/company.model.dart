import 'package:tractian_mobile_challenge/core/domain/company.entity.dart';

class CompanyModel extends Company {
  const CompanyModel({required super.id, required super.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(id: json['id'], name: json['name']);
}
