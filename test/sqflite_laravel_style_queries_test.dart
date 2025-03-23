
import 'package:example/models/UserNewModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_laravel_style_queries/helper/models/column_types.dart';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';
import 'models/UserDbModel.dart';
import 'models/UserBookDbModel.dart';

void main() {
  test('open database', () async {


    // open database
    // old way
    // SqfliteEasyDb().open();
    // new way
    await AzSqflite().open();

    print('start 1');

    // create database table example new way
    print('Create table');
    await UserNewModel()
        .addColumn(name: "id", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
        .addColumn(name: "name", type: ColumnType.text, isNull: true)
        .addColumn(name: "fatherName", type: ColumnType.text, isNull: true)
        .execute();

    UserNewModel user = await UserNewModel().where('id', 091).first();
    user.name = 'hassan3';
    user = await user.save();
    print(user.id);

    dynamic r = await UserNewModel().get();
    print(r);

    //

    //
    // print('start 2');
    //
    // // insert records examples
    // // old way
    // // UserModel(name: "hassan 2", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
    // // new way
    // print('insert record');
    // await AzSqflite().table('users4').insert({"name": "hassan 1", "fatherName": "Khawaja Muhammad Asghar Saqi"});
    // await AzSqflite().table('users4').insert({"name": "hassan 2", "fatherName": "Khawaja Muhammad Asghar Saqi"});
    //
    // print('start 3');
    //
    // // get records example
    // print("get records after insert");
    // print(await AzSqflite().table('users4').get());
    //
    // print('start 4');
    //
    // // update record example
    // await AzSqflite().table('users4').where('id', 13).update({"name": "hassan update 1", "fatherName": "Khawaja Muhammad Asghar Saqi"});
    //
    // print('start 5');
    //
    // print("get records after update");
    // print(await AzSqflite().table('users4').get());
    //
    // print('start 6');
    //
    // // delete single records example
    // print('delete record');
    // await AzSqflite().table('users4').where('id', 1).delete();
    //
    // print('start 7');
    //
    // print("get records after delete one record");
    // print(await AzSqflite().table('users4').get());
    //
    // print('start 8');
    //
    // // delete all records example
    // // print('delete all records');
    // // await AzSqflite().table('users4').delete();
    //
    //
    // print('start 9');
    //
    // // print("get record after delete all");
    // // print(await AzSqflite().table('users4').get());
    //
    // print('start 10');
    //
    // print('count record');
    // print(await AzSqflite().table('users4').count());
    //
    // print('start 11');

  });

}
