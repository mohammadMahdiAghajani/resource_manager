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

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    bookPageId = m['book_page_id'];
    pageId = m['page_id'];
    bookId = m['book_id'];
    pageNumber = m['page_number'];
    pageText = m['page_text'];
    createdBy = m['created_by'];
    footer = m['footer'];
  }

  @override
  void fromMap(Map<dynamic, dynamic> map) {
    // TODO: implement fromMap
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
