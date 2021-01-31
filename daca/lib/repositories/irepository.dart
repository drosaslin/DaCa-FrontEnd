abstract class IRepository<T> {
  Future<List<T>> getList();
  Future<List<T>> getListById(String id);
  Future<T> getById(String id);
  Future<T> create(T t);
  Future<T> update(T t);
  Future<T> delete(T t);
}
