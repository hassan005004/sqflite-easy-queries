
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_laravel_style_queries/helper/models/column_types.dart';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';
import 'models/UserDbModel.dart';
import 'models/UserBookDbModel.dart';

void main() {
  test('open database', () async {

    // open database
    await SqfliteEasyDb().open();

    // create tables
    UserDbModel()
        .addColumn(name: "id", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
        .addColumn(name: "name", type: ColumnType.text, isNUll: true)
        .addColumn(name: "father_name", type: ColumnType.text, isNUll: true)
        .execute();
    //
    // UserBookDbModel()
    //     .addColumn(name: "id", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
    //     .addColumn(name: "user_id", type: ColumnType.integer, isNUll: false)
    //     .addColumn(name: "name", type: ColumnType.text, isNUll: true)
    //     .execute();
    //
    // // insert records
    UserDbModel(name: "hassan 1", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
    // UserBookDbModel(userId: 1, name: "zahidaz.com").insert();
    UserDbModel(name: "hassan 2", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
    // UserBookDbModel(userId: 2, name: "zahidaz.com").insert();
    UserDbModel(name: "hassan 3", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
    // UserBookDbModel(userId: 3, name: "zahidaz.com").insert();

    // get records example
    print("get all records");
    print(await UserDbModel().get());

    // update record example
    UserDbModel(name: "abc").where(UserDbModel().id, 1).update();
    print("get all records after update");
    print(await UserDbModel().get());

    // delete one record example
    UserDbModel().where(UserDbModel().id, 1).delete();
    print("get all records after delete one");
    print(await UserDbModel().get());

    // insert record with id example
    UserDbModel(id: 1, name: "change", fatherName: "").insert();
    print("get all records after insert with id");
    print(await UserDbModel().get());

    // delete all records example
    UserDbModel().delete();
    print("no record after delete all");
    print(await UserDbModel().get());

    // example of get records
    // SqfliteEasyDb().removeAllTables();
    // print(await UserDbModel().count());
    // print(await UserDbModel().count());
    // print(await UserDbModel().get());
    // print((await UserDbModel().get().toString()));
    // print(userDbModelFromJsonList(jsonEncode(await UserDbModel().user_books().get())));
    // dynamic _users = await UserDbModel().get();
    // List<UserDbModel> users = userDbModelFromJsonList(jsonEncode(_users));
    // print(users[0].name);
    // print(users[0].fatherName);
  });


}
