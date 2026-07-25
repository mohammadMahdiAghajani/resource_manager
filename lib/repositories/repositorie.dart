import 'package:book_adder_2/models/interface/model.dart';

abstract class Repositorie {
  Future<bool> read(Model model);

  Future<bool> create(Model model);

  Future<bool> delete(Model model);

  Future<bool> update(Model model);
}
