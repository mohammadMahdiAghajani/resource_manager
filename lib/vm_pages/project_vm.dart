import 'package:book_adder_2/models/author.dart';
import 'package:book_adder_2/models/contents/book.dart';
import 'package:book_adder_2/models/contents/short_articles.dart';
import 'package:book_adder_2/models/project.dart';
import 'package:book_adder_2/models/resource.dart';
import 'package:book_adder_2/repositories/author_repositorie.dart';
import 'package:book_adder_2/repositories/book_repositorie.dart';
import 'package:book_adder_2/repositories/project_repositorie.dart';
import 'package:book_adder_2/repositories/resource_repositorie.dart';
import 'package:book_adder_2/repositories/short_article_repositorie.dart';
import 'package:flutter/material.dart';

class ProjectVM {
  final projectList = ValueNotifier<List<Project>>([]);
  final currentProject = ValueNotifier<Project?>(null);
  final resources = ValueNotifier<List<Resource>>([]);
  final authors = ValueNotifier<List<Author>>([]);
  final pageState = ValueNotifier<ProjectPageState>(.projectInfo);

  final resourceRepo = ResourceRepositorie();
  final projectRepo = ProjectRepositorie();
  final authorsRepo = AuthorRepositorie();
  final bookRepo = BookRepositorie();
  final shortArticlesRepo = ShortArticleRepositorie();

  int resourcePageNumber = 1;
  int authorPageNumber = 1;

  VoidCallback? onProjectInfoSave;

  Future<bool> onSelectProject(Project project) async {
    switch (pageState.value) {
      case .projectInfo:
      case .resource:
        await getResources();
      case .author:
    }
    return true;
  }

  Future<List<Project>> getProjectList() async {
    final r = projectRepo.getProjectList();
    projectList.value = await r;
    if (projectList.value.isNotEmpty)
      currentProject.value = projectList.value[0];
    return r;
  }

  Future<bool> setProjectInfo() async {
    onProjectInfoSave!();
    final r = await projectRepo.update(currentProject.value!);
    return true;
  }

  Future<bool> onDeleteProject() async {
    final r = await projectRepo.delete(currentProject.value!);
    getProjectList();
    return true;
  }

  Future<bool> onAddProject(Project project) async {
    final r = await projectRepo.create(project);
    getProjectList();
    return true;
  }

  Future<bool> getResources() async {
    resources.value = await resourceRepo.getResourceList(
      currentProject.value!,
      resourcePageNumber,
      20,
    );
    pageState.notifyListeners();
    return true;
  }

  Future<bool> onAddResource(Resource resource) async {
    final r = await resourceRepo.create(resource);
    await getResources();
    pageState.notifyListeners();
    return true;
  }

  Future<bool> onDeleteResource(Resource resource) async {
    final r = await resourceRepo.delete(resource);
    await getResources();
    pageState.notifyListeners();
    return true;
  }

  Future<List<Project>> getProjectAoutors() async {
    return [];
  }

  Future<List<Project>> getProjectResources() async {
    return [];
  }

  Future<bool> onAddAuthor(Author author) async {
    final r = await authorsRepo.create(author);
    await getAuthors();
    pageState.notifyListeners();
    return true;
  }

  Future<bool> getAuthors() async {
    authors.value = await authorsRepo.getAuthorList(authorPageNumber, 20);
    pageState.notifyListeners();
    return true;
  }

  Future<bool> onDeleteAuthor(Author author) async {
    final r = await authorsRepo.delete(author);
    await getAuthors();
    pageState.notifyListeners();
    return true;
  }
}

enum ProjectPageState { resource, author, projectInfo }
