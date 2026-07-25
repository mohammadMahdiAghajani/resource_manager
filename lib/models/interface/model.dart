abstract class Model {
  Model();

  void fromJson(String json);
  void fromMap(Map map);
  String toJson();
}
