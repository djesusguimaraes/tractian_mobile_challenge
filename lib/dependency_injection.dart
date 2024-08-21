import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart' as dio;
import 'package:tractian_mobile_challenge/domain/http/assets.service.dart';
import 'package:tractian_mobile_challenge/domain/http/companies.service.dart';
import 'package:tractian_mobile_challenge/domain/http/locations.service.dart';

import 'core/http/dio.client.dart';

void injectDependencies() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<dio.Dio>(getCachedApiClient);

  getIt.registerLazySingleton<CompaniesService>(() => CompaniesService(client: getIt(), path: ''));

  getIt.registerLazySingleton<LocationsService>(() => LocationsService(client: getIt(), path: 'locations'));

  getIt.registerLazySingleton<AssetsService>(() => AssetsService(client: getIt(), path: 'assets'));
}
