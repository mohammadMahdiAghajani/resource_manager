import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/interface/content.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:book_adder_2/repositories/resource_repositorie.dart';
import 'package:book_adder_2/repositories/short_article_repositorie.dart';
import 'package:flutter/material.dart';

class ResourceManagerVM extends ChangeNotifier {
  final Resource currentResource;
  final ResourceRepositorie resourceRepo;
  final BookRepositorie bookRepo;
  final ShortArticleRepositorie shortArticlesRepo;
  List<Content> contents = [];

  ResourceManagerVM({
    required this.currentResource,
    required this.resourceRepo,
    required this.bookRepo,
    required this.shortArticlesRepo,
  });

  int pageNumber = 1;

  Future<void> getContents() async {
    contents = await bookRepo.getBookList(currentResource, pageNumber, 20);
    contents.forEach(print);
    print('----------');
    notifyListeners();
  }

  Future<bool> createBook(Book book) async {
    final r = await bookRepo.create(book);
    await getContents();
    return true;
  }
}
