import 'dart:convert';
import 'package:book_adder_2/models/interface/model.dart';

class BookPage extends Model {
  int? bookPageId;
  int? pageId;
  int? bookId;
  int? pageNumber;
  String? pageText;
  String? footer;
  String? createdBy;
  BookPage({
    this.bookPageId,
    this.pageId,
    this.bookId,
    this.pageNumber,
    this.pageText,
    this.createdBy,
    this.footer,
  });

  factory BookPage.fromJson(String json) {
    return BookPage()..fromJson(json);
  }
  factory BookPage.fromMap(Map map) {
    return BookPage()..fromMap(map);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    fromMap(m);
  }

  @override
  void fromMap(Map map) {
    bookPageId = map['book_page_id'];
    pageId = map['page_id'];
    bookId = map['book_id'];
    pageNumber = map['page_number'];
    pageText = map['page_text'];
    createdBy = map['created_by'];
    footer = map['footer'];
  }

  @override
  String toJson() {
    final m = {
      'book_page_id': bookPageId,
      'page_id': pageId,
      'book_id': bookId,
      'page_number': pageNumber,
      'page_text': pageText,
      'created_by': createdBy,
      'footer': footer,
    };
    return jsonEncode(m);
  }
}
