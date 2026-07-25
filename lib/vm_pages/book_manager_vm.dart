import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:flutter/material.dart';

class BookManagerVM extends ChangeNotifier {
  final Book book;
  final BookRepositorie bookRepo;
  BookManagerVM({required this.book, required this.bookRepo});
}
