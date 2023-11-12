
import 'dart:convert';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

List<UserBookDbModel> userBookDbModelFromJsonList(String str) => List<UserBookDbModel>.from(json.decode(str).map((x) => UserBookDbModel.fromJson(x)));
UserBookDbModel userBookDbModelFromJsonSingle(String str) => UserBookDbModel.fromJson(json.decode(str));
String userBookDbModelToJson(List<UserBookDbModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class UserBookDbModel extends SqfliteEasyDb{
  // these are table defining terms
  String tableName = 'user_books';
  // String autoIncrementColumn = 'id';


  // below is like your normal model calss
  int? id;
  int? userId;
  String? name;

  UserBookDbModel({
    this.id,
    this.userId,
    this.name,
  });

  factory UserBookDbModel.fromJson(Map<String, dynamic> json) => UserBookDbModel(
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