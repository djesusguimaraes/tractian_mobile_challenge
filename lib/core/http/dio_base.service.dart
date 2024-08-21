abstract class DioBase<T, ID> {
  final String path;

  DioBase({required this.path});

  Future<T> get(ID id);

  Future<List<T>> getAll();

  Future<T> create(T model);

  Future<T> update(T model);

  Future<void> delete(ID id);

  JsonModelConvert<T> get converter;
}

typedef FromJson<T> = T Function(Map<String, dynamic> data);
typedef ToJson<T> = Map<String, dynamic> Function(T model);

class JsonModelConvert<T> {
  FromJson<T> fromJson;
  ToJson<T>? toJson;

  JsonModelConvert({required this.fromJson, this.toJson});
}
