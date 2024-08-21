import 'package:dio/dio.dart' as dio;
import 'package:tractian_mobile_challenge/core/env/env_config.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

dio.Dio getCachedApiClient() {
  final client = dio.Dio(dio.BaseOptions(baseUrl: EnvConfig.apiUrl));
  client.interceptors.addAll({
    PrettyDioLogger(requestBody: true, responseBody: false, responseHeader: true, maxWidth: 60),
    DioCacheInterceptor(options: CacheOptions(store: MemCacheStore()))
  });
  return client;
}
