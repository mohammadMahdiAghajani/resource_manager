import 'dart:convert';
import 'package:book_adder_2/models/interface/model.dart';

class Project extends Model {
  int? projectId;
  int? revisionNumber;
  int? projectOwner;
  String? projectName;
  String? description;
  String? startedAt;
  String? finishedAt;
  String? createdBy;
  Project({
    this.projectId,
    this.revisionNumber,
    this.projectOwner,
    this.projectName,
    this.description,
    this.startedAt,
    this.finishedAt,
    this.createdBy,
  });

  factory Project.fromJson(String json) {
    return Project()..fromJson(json);
  }
  factory Project.fromMap(Map map) {
    return Project()..fromMap(map);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    fromMap(m);
  }

  @override
  void fromMap(Map map) {
    projectId = map['project_id'];
    projectName = map['project_name'];
    description = map['description'];
    startedAt = map['started_at'];
    finishedAt = map['finished_at'];
    revisionNumber = map['revision_number'];
    projectOwner = map['project_owner'];
    createdBy = map['created_by'];
  }

  @override
  String toJson() {
    final m = {
      'project_id': projectId,
      'project_name': projectName,
      'description': description,
      'started_at': startedAt,
      'finished_at': finishedAt,
      'revision_number': revisionNumber,
      'project_owner': projectOwner,
      'created_by': createdBy,
    };
    return jsonEncode(m);
  }
}
