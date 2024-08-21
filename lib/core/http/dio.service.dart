import 'package:dio/dio.dart';
import 'dio_base.service.dart';

abstract class DioService<T, ID> extends DioBase<T, ID> {
  final Dio client;

  DioService({required this.client, required super.path});

  @override
  Future<List<T>> getAll() async {
    try {
      final endpoint = path.isNotEmpty ? '/$path' : '';
      final response = await client.get(endpoint);
      final data = (response.data as List).cast<Map<String, dynamic>>();
      return data.map(converter.fromJson).toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<T> get(ID id) => throw UnimplementedError();

  @override
  Future<T> create(T model) => throw UnimplementedError();

  @override
  Future<T> update(T model) => throw UnimplementedError();

  @override
  Future<void> delete(ID id) => throw UnimplementedError();
}
