import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

class UserNewModel extends AzSqflite {
  // Override tableName as a getter to supply the proper table name.
  @override
  String get tableName => 'users2';

  // Public fields for direct assignment.
  int? id;
  String? name;
  String? fatherName;

  UserNewModel();

  @override
  Map<String, dynamic> toJson() => {
    if (id != null) "id": id,
    if (name != null) "name": name,
    if (fatherName != null) "father_name": fatherName,
  };

  @override
  UserNewModel fromJson(Map<String, dynamic> json) {
    return UserNewModel()
      ..id = json['id']
      ..name = json['name']
      ..fatherName = json['father_name'];
  }
}
