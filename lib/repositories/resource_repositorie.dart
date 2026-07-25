import 'package:book_adder_2/models/interface/content.dart';
import 'package:book_adder_2/models/interface/model.dart';
import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/resource_service.dart';

typedef ResourceMap = Map<Resource, List<Content>>;

class ResourceRepositorie implements Repositorie {
  final resourceService = ResourceService();

  Future<List<Resource>> getResourceList(
    Project project,
    int pageNumber,
    int pageSize,
  ) async {
    final r = await resourceService.getResourceList(
      project,
      pageNumber,
      pageSize,
    );
    return r;
  }

  @override
  Future<bool> read(covariant Resource resource) async {
    return true;
  }

  @override
  Future<bool> create(covariant Resource resource) async {
    final r = await resourceService.create(resource);
    return true;
  }

  @override
  Future<bool> delete(covariant Resource resource) async {
    final r = await resourceService.delete(resource);
    return true;
  }

  @override
  Future<bool> update(covariant Resource resource) async {
    return true;
  }
}
