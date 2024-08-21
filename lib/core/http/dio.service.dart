import 'package:dio/dio.dart';
import 'dio_base.service.dart';

abstract class DioService<T, ID> extends DioBase<T, ID> {
  final Dio client;

  DioService({required this.client, required super.path});

  @override
  Future<T> get(ID id) async {
    try {
      final response = await client.get('/$id/$path');
      final data = response.data;
      return converter.fromJson(data);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<T>> getAll() async {
    try {
      final response = await client.get('/$path');
      final List<Map<String, dynamic>> data = response.data;
      return data.map(converter.fromJson).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<T> create(T model) => throw UnimplementedError();

  @override
  Future<T> update(T model) => throw UnimplementedError();

  @override
  Future<void> delete(ID id) => throw UnimplementedError();
}
