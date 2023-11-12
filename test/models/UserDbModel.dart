
import 'dart:convert';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

List<UserDbModel> userDbModelFromJsonList(String str) => List<UserDbModel>.from(json.decode(str).map((x) => UserDbModel.fromJson(x)));
UserDbModel userDbModelFromJsonSingle(String str) => UserDbModel.fromJson(json.decode(str));
String userDbModelToJson(List<UserDbModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDbModel extends SqfliteEasyDb{
  // these are table defining terms
  String tableName = 'users';

  // below is like your normal model calss
  int? id;
  String? name;
  String? fatherName;


  UserDbModel({
    this.id,
    this.name,
    this.fatherName,
  });

  factory UserDbModel.fromJson(Map<String, dynamic> json) => UserDbModel(
    id: json["id"],
    name: json["name"],
    fatherName: json["father_name"],
  );

  Map<String, dynamic> toJson() => {
    // normal toJson
    if (id != null) "id": id,
    if (name != null) "name": name,
    if (fatherName != null) "father_name": fatherName,
  };
}