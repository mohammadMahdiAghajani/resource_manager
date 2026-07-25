import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/book_service.dart';

class BookRepositorie implements Repositorie {
  final bookService = BookService();

  Future<List<Book>> getBookList(
    Resource resource,
    int pageNumber,
    int pageSize,
  ) async {
    final r = await bookService.getBookList(resource, pageNumber, pageSize);
    return r;
  }

  Future<bool> read(covariant Book book) async {
    return true;
  }

  @override
  Future<bool> create(covariant Book book) async {
    final r = await bookService.create(book);
    return true;
  }

  @override
  Future<bool> delete(covariant Book book) async {
    final r = await bookService.delete(book);
    return true;
  }

  @override
  Future<bool> update(covariant Book book) async {
    return true;
  }
}
