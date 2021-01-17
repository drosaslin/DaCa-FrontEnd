abstract class IRepository<T> {
  Future<List<T>> getList();
  Future<T> getById(String id);
  Future<T> create(T t);
  Future<T> update(T t);
  Future<T> delete(T t);
}
