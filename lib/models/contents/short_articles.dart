import 'dart:convert';
import 'package:book_adder_2/models/interface/content.dart';

class ShortArticle extends Content {
  int? articleId;
  int? resourceId;
  String? subject;
  String? topic;
  String? source;
  String? tags;
  String? url;
  String? fullText;
  String? createdBy;
  ShortArticle({
    this.articleId,
    this.resourceId,
    this.subject,
    this.topic,
    this.source,
    this.tags,
    this.url,
    this.fullText,
    this.createdBy,
  });

  factory ShortArticle.fromJson(String json) {
    return ShortArticle()..fromJson(json);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    articleId = m['article_id'];
    resourceId = m['resource_id'];
    subject = m['subject'];
    topic = m['topic'];
    source = m['source'];
    tags = m['tags'];
    url = m['url'];
    fullText = m['full_text'];
    createdBy = m['created_by'];
  }

  @override
  void fromMap(Map<dynamic, dynamic> map) {
    // TODO: implement fromMap
  }

  @override
  String toJson() {
    final m = {
      'article_id': articleId,
      'resource_id': resourceId,
      'subject': subject,
      'topic': topic,
      'source': source,
      'tags': tags,
      'url': url,
      'full_text': fullText,
      'created_by': createdBy,
    };
    return jsonEncode(m);
  }
}
