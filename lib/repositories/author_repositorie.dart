import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/interface/model.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/author_service.dart';

class AuthorRepositorie implements Repositorie {
  final authorService = AuthorService();

  Future<List<Author>> getAuthorList(int pageNumber, int pageSize) async {
    final r = await authorService.getAuthorList(pageNumber, pageSize);
    return r;
  }

  @override
  Future<bool> create(covariant Author author) async {
    final r = await authorService.create(author);
    return true;
  }

  @override
  Future<bool> delete(covariant Author author) async {
    final r = await authorService.delete(author);
    return true;
  }

  @override
  Future<bool> read(covariant Author author) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<bool> update(covariant Author author) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
