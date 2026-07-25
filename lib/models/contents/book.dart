import 'dart:convert';
import 'package:book_adder_2/models/interface/content.dart';

class Book extends Content {
  int? bookId;
  int? resourceId;
  int? edition;
  int? pageCount;
  String? bookName;
  String? isbn;
  String? publisherName;
  String? publishDate;
  String? filePath;
  String? fullText;
  String? tableOfContents;
  String? subject;
  String? references;
  String? createdBy;
  Book({
    this.bookId,
    this.resourceId,
    this.edition,
    this.pageCount,
    this.bookName,
    this.isbn,
    this.publisherName,
    this.publishDate,
    this.filePath,
    this.fullText,
    this.tableOfContents,
    this.subject,
    this.references,
    this.createdBy,
  });

  factory Book.fromJson(String json) {
    return Book()..fromJson(json);
  }
  factory Book.fromMap(Map map) {
    return Book()..fromMap(map);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    fromMap(m);
  }

  @override
  void fromMap(Map map) {
    bookId = map['book_id'];
    resourceId = map['resource_id'];
    edition = map['edition'];
    pageCount = map['page_count'];
    bookName = map['book_name'];
    isbn = map['isbn'];
    publisherName = map['publisher_name'];
    publishDate = map['publish_date'];
    filePath = map['file_path'];
    fullText = map['full_text'];
    tableOfContents = map['table_of_contents'];
    subject = map['subject'];
    references = map['references'];
    createdBy = map['created_by'];
  }

  @override
  String toJson() {
    final m = {
      'book_id': bookId,
      'resource_id': resourceId,
      'book_name': bookName,
      'isbn': isbn,
      'edition': edition,
      'page_count': pageCount,
      'publisher_name': publisherName,
      'publish_date': publishDate,
      'file_path': filePath,
      'full_text': fullText,
      'references': references,
      'table_of_contents': tableOfContents,
      'subject': subject,
      'created_by': createdBy,
    };
    return jsonEncode(m);
  }
}
