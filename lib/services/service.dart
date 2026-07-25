import 'package:book_adder_2/models/interface/model.dart';
import 'package:dio/dio.dart';

abstract class Service {
  Future<Response> read(Model model);

  Future<Response> create(Model model);

  Future<Response> delete(Model model);

  Future<Response> update(Model model);
}
