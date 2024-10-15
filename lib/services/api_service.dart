abstract class ApiService<T> {
  Future<List<T>> getAll();
  Future<T> getOne(int id);
  Future<void> create(T item);
  Future<void> update(int id, T item);
  Future<void> delete(int id);
}
