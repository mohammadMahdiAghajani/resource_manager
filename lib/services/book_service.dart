import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/services/a_network.dart';
import 'package:book_adder_2/services/service.dart';
import 'package:dio/dio.dart';

class BookService implements Service {
  Future<List<Book>> getBookList(
    Resource resource,
    int pageNumber,
    int pageSize,
  ) async {
    final r = await dio.get(
      '/book/list',
      options: Options(
        headers: {
          'resource-id': resource.resourceId,
          'page-number': pageNumber,
          'page-size': pageSize,
        },
      ),
    );
    final list = (r.data['books'] as List).map((e) => Book.fromMap(e)).toList();
    return list;
  }

  Future<Response> read(covariant Book book) {
    throw UnimplementedError();
  }

  @override
  Future<Response> create(covariant Book book) async {
    final r = await dio.post('/book/', data: book.toJson());
    return r;
  }

  @override
  Future<Response> delete(covariant Book book) async {
    final r = await dio.delete(
      '/book/',
      options: Options(headers: {'resource-id': book.resourceId}),
    );
    return r;
  }

  @override
  Future<Response> update(covariant Book book) {
    throw UnimplementedError();
  }
}
