import 'package:book_adder_2/models/interface/content.dart';
import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/services/a_network.dart';
import 'package:book_adder_2/services/service.dart';
import 'package:dio/dio.dart';

typedef ResourceMap = Map<Resource, List<Content>>;

class ResourceService implements Service {
  Future<List<Resource>> getResourceList(
    Project project,
    int pageNumber,
    int pageSize,
  ) async {
    final r = await dio.get(
      '/resource/list',
      options: Options(
        headers: {
          'project-id': project.projectId,
          'page-number': pageNumber,
          'page-size': pageSize,
        },
      ),
    );
    final list = (r.data['resources'] as List)
        .map((e) => Resource.fromMap(e))
        .toList();
    return list;
  }

  ResourceMap getResourceMap() {
    return {};
  }

  @override
  Future<Response> read(covariant Resource resource) {
    throw UnimplementedError();
  }

  @override
  Future<Response> create(covariant Resource resource) async {
    final r = await dio.post('/resource/', data: resource.toJson());
    return r;
  }

  @override
  Future<Response> delete(covariant Resource resource) async {
    final r = await dio.delete(
      '/resource/',
      options: Options(headers: {'resource-id': resource.resourceId}),
    );
    return r;
  }

  @override
  Future<Response> update(covariant Resource resource) {
    throw UnimplementedError();
  }
}
