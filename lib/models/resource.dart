import 'dart:convert';
import 'package:book_adder_2/models/interface/model.dart';

class Resource extends Model {
  int? resourceId;
  int? projectId;
  int? version;
  String? resourceName;
  String? resourceType;
  String? createdAt;
  String? url;
  String? createdBy;
  Resource({
    this.resourceId,
    this.projectId,
    this.version,
    this.resourceName,
    this.resourceType,
    this.createdAt,
    this.url,
    this.createdBy,
  }) {
    if (resourceTypes.contains(resourceType) == false) {
      resourceType = resourceTypes[0];
    }
  }

  factory Resource.fromJson(String json) {
    return Resource()..fromJson(json);
  }

  factory Resource.fromMap(Map map) {
    return Resource()..fromMap(map);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    fromMap(m);
  }

  @override
  void fromMap(Map map) {
    resourceId = map['resource_id'];
    projectId = map['project_id'];
    version = map['version'];
    resourceName = map['resource_name'];
    resourceType = map['resource_type'];
    createdAt = map['created_at'];
    url = map['url'];
    createdBy = map['created_by'];
  }

  @override
  String toJson() {
    final m = {
      'resource_id': resourceId,
      'project_id': projectId,
      'version': version,
      'resource_name': resourceName,
      'resource_type': resourceType,
      'created_at': createdAt,
      'url': url,
      'created_by': createdBy,
    };
    return jsonEncode(m);
  }

  static const List<String> resourceTypes = [
    'book',
    'journal',
    'article',
    'news',
    'podcast',
    'workshop',
    'qa',
    'document',
    'lecture',
  ];

  String get resourceTypePersion {
    const map = {
      'book': 'کتاب',
      'journal': 'مقاله جزنالی',
      'article': 'مقاله کوتاه',
      'news': 'اخبار',
      'podcast': 'پادکست',
      'workshop': 'کارگاه',
      'qa': 'پرسش و پاسخ',
      'document': 'مستندات',
      'lecture': 'سخنرانی ها',
    };
    return map[resourceType] ?? '';
  }
}
