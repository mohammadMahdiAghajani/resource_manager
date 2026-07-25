import 'dart:convert';
import 'package:book_adder_2/models/interface/model.dart';

class Author extends Model {
  int? authorId;
  String? firstName;
  String? lastName;
  String? bio;
  String? phoneNumber;
  String? email;
  String? homePage;
  String? organizationName;
  String? city;
  String? country;
  String? createdAt;
  String? createdBy;
  Author({
    this.authorId,
    this.firstName,
    this.lastName,
    this.bio,
    this.phoneNumber,
    this.email,
    this.homePage,
    this.organizationName,
    this.city,
    this.country,
    this.createdAt,
    this.createdBy,
  });

  factory Author.fromJson(String json) {
    return Author()..fromJson(json);
  }
  factory Author.fromMap(Map map) {
    return Author()..fromMap(map);
  }

  @override
  void fromJson(String json) {
    final m = jsonDecode(json);
    fromMap(m);
  }

  @override
  void fromMap(Map map) {
    authorId = map['author_id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    bio = map['bio'];
    phoneNumber = map['phone_number'];
    email = map['email'];
    homePage = map['home_page'];
    organizationName = map['organization_name'];
    city = map['city'];
    country = map['country'];
    createdAt = map['created_at'];
    createdBy = map['created_by'];
  }

  @override
  String toJson() {
    final m = {
      'author_id': authorId,
      'first_name': firstName,
      'last_name': lastName,
      'bio': bio,
      'phone_number': phoneNumber,
      'email': email,
      'home_page': homePage,
      'organization_name': organizationName,
      'city': country,
      'country': country,
      'created_at': createdAt,
      'created_by': createdBy,
    };
    return jsonEncode(m);
  }
}
