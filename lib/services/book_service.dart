import 'dart:convert';
import 'dart:io';

import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/book_page.dart';
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

  @override
  Future<Response> read(covariant Book book) async {
    final r = await dio.get(
      '/book/',
      options: Options(headers: {'book-id': book.bookId}),
    );
    return r;
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
  Future<Response> update(covariant Book book) async {
    final r = await dio.put('/book/', data: book.toJson());
    return r;
  }

  //-------------------------------
  Future<List<Author>> getBookAuthors(Book book) async {
    final r = await dio.get(
      '/book/authors',
      options: Options(headers: {'book-id': book.bookId}),
    );
    final list = (r.data as List).map((e) => Author.fromMap(e)).toList();
    return list;
  }

  Future<Response> updateAuthors(List<Author> authors, int bookId) async {
    final r = await dio.put(
      '/book/authors',
      options: Options(headers: {'book-id': bookId}),
      data: jsonEncode(authors.map((a) => a.authorId!).toList()),
    );
    return r;
  }

  Future<Map> extractBookFromServerFile({
    String filePath = '',
    int bookId = 0,
    int tocStart = 1,
    int tocEnd = 1,
  }) async {
    final r = await dio.post(
      '/book/extract_data/file',
      options: Options(
        headers: {
          'file-path': filePath,
          'book-id': bookId,
          'toc-start-page': tocStart,
          'toc-end-page': tocEnd,
        },
      ),
    );
    return r.data;
  }

  Future<String> getBookFullText(Book book) async {
    final r = await dio.get(
      '/book/full_text',
      options: Options(headers: {'book-id': book.bookId}),
    );
    return r.data;
  }

  Future<dynamic> getPageByNumber(int bookId, int pageNumber) async {
    final r = await dio.get(
      '/book/page/page_number',
      options: Options(headers: {'book-id': bookId, 'page-number': pageNumber}),
    );
    return r.data;
  }

  Future<dynamic> updatePage(BookPage page) async {
    final r = await dio.put('/book/page', data: page.toJson());
    return r.data;
  }
}
