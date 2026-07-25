import 'dart:convert';

import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/services/service.dart';
import 'package:dio/dio.dart';
import 'a_network.dart';

class ProjectService implements Service {
  Future<List<Project>> getProjectList() async {
    final r = await dio.get('/project/list');
    final list = (r.data as List).map((e) => Project.fromMap(e)).toList();
    return list;
  }

  @override
  Future<Response> read(covariant Project project) {
    throw UnimplementedError();
  }

  @override
  Future<Response> create(covariant Project project) async {
    final r = await dio.post('/project/', data: project.toJson());
    return r;
  }

  @override
  Future<Response> delete(covariant Project project) async {
    final r = await dio.delete(
      '/project/',
      options: Options(headers: {'project-id': project.projectId}),
    );
    return r;
  }

  @override
  Future<Response> update(covariant Project project) async {
    print(project.toJson());
    final r = dio.put(
      '/project/',
      data: jsonDecode(project.toJson()),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return r;
  }
}
