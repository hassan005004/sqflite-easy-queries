
import 'dart:convert';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

List<UserBookModel> UserBookModelFromJsonList(String str) => List<UserBookModel>.from(json.decode(str).map((x) => UserBookModel.fromJson(x)));
UserBookModel UserBookModelFromJsonSingle(String str) => UserBookModel.fromJson(json.decode(str));
String UserBookModelToJson(List<UserBookModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class UserBookModel extends SqfliteEasyDb{
  // these are table defining terms
  String tableName = 'user_books';
  // String autoIncrementColumn = 'id';


  // below is like your normal model calss
  int? id;
  int? userId;
  String? name;

  UserBookModel({
    this.id,
    this.userId,
    this.name,
  });

  factory UserBookModel.fromJson(Map<String, dynamic> json) => UserBookModel(
    id: json["id"],
    userId: json["user_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    // normal toJson
    if (id != null) "id": id,
    if (userId != null) "user_id": userId,
    if (name != null) "name": name,
  };
}