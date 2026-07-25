import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/repositories/repositorie.dart';
import 'package:book_adder_2/services/project_service.dart';

class ProjectRepositorie implements Repositorie {
  final projectService = ProjectService();

  Future<List<Project>> getProjectList() async {
    final list = await projectService.getProjectList();
    return list;
  }

  @override
  Future<bool> read(covariant Project project) async {
    return true;
  }

  @override
  Future<bool> create(covariant Project project) async {
    final r = await projectService.create(project);
    return true;
  }

  @override
  Future<bool> delete(covariant Project project) async {
    final r = await projectService.delete(project);
    return true;
  }

  @override
  Future<bool> update(covariant Project project) async {
    projectService.update(project);
    return true;
  }
}
