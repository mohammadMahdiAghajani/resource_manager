import 'package:book_adder_2/models/contents/short_articles.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/short_article_service.dart';

class ShortArticleRepositorie implements Repositorie {
  final shortArticleService = ShortArticleService();

  @override
  Future<ShortArticle> read(covariant ShortArticle shortArticle) async {
    return ShortArticle();
  }

  @override
  Future<bool> create(covariant ShortArticle shortArticle) async {
    return true;
  }

  @override
  Future<bool> delete(covariant ShortArticle shortArticle) async {
    return true;
  }

  @override
  Future<bool> update(covariant ShortArticle shortArticle) async {
    return true;
  }
}
