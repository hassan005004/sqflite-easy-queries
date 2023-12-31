
import 'dart:convert';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

List<UserModel> UserModelFromJsonList(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));
UserModel UserModelFromJsonSingle(String str) => UserModel.fromJson(json.decode(str));
String UserModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel extends SqfliteEasyDb{
  // these are table defining terms
  String tableName = 'users';

  // below is like your normal model calss
  int? id;
  String? name;
  String? fatherName;


  UserModel({
    this.id,
    this.name,
    this.fatherName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
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