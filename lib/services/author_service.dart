import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/services/a_network.dart';
import 'package:book_adder_2/services/service.dart';
import 'package:dio/dio.dart';

class AuthorService implements Service {
  Future<List<Author>> getAuthorList(int pageNumber, int pageSize) async {
    final r = await dio.get(
      '/author/list',
      options: Options(
        headers: {'page-number': pageNumber, 'page-size': pageSize},
      ),
    );
    final list = (r.data['authors'] as List)
        .map((e) => Author.fromMap(e))
        .toList();
    return list;
  }

  @override
  Future<Response> create(covariant Author author) async {
    final r = await dio.post('/author/', data: author.toJson());
    return r;
  }

  @override
  Future<Response> delete(covariant Author author) async {
    final r = await dio.delete(
      '/author/',
      options: Options(headers: {'author-id': author.authorId}),
    );
    return r;
  }

  @override
  Future<Response> read(covariant Author author) async {
    final res = await dio.post('author', data: author.toJson());
    return res;
  }

  @override
  Future<Response> update(covariant Author author) async {
    final res = await dio.post('author', data: author.toJson());
    return res;
  }
}
