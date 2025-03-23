import 'package:flutter/material.dart';
import 'package:example/models/UserModel.dart';
import 'package:sqflite_laravel_style_queries/helper/models/column_types.dart';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

import 'models/UserNewModel.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // open database
  await AzSqflite().open();

  print('start 1');


  // create database table example new way
  print('Create table');
  await AzSqflite().table('users6')
      .addColumn(name: "id", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
      .addColumn(name: "name", type: ColumnType.text, isNUll: true)
      .addColumn(name: "fatherName", type: ColumnType.text, isNUll: true)
      .execute();

  print('start 2');

  // insert records examples
  // old way
  // UserModel(name: "hassan 2", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
  // new way
  print('insert record');
  await AzSqflite().table('users6').insert({"name": "hassan 1", "fatherName": "Khawaja Muhammad Asghar Saqi"});
  await AzSqflite().table('users6').insert({"name": "hassan 2", "fatherName": "Khawaja Muhammad Asghar Saqi"});

  print('start 3');

  // get records example
  print("get records after insert");
  print(await AzSqflite().table('users6').get());

  print('start 4');

  // update record example
  print("update record");
  await AzSqflite().table('users6').where('id', 1).update({"name": "hassan update 1", "fatherName": "Khawaja Muhammad Asghar Saqi"});

  print('start 5');

  print("get records after update");
  print(await AzSqflite().table('users6').get());

  print('start 6');

  // delete single records example
  print('delete record');
  await AzSqflite().table('users6').where('id', 1).delete();

  print('start 7');

  print("get records after delete one record");
  print(await AzSqflite().table('users6').get());

  print('start 8');

  // delete all records example
  print('delete all records');
  await AzSqflite().table('users6').delete();

  print('start 9');

  print("get record after delete all");
  print(await AzSqflite().table('users6').get());

  print('start 10');

  print('count records');
  print(await AzSqflite().table('users6').count());

  print('start 11');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlflite Laravel Style Quries',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: false,
      ),
      home: const MyHomePage(title: 'Example of package'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Laravel 5 Style"),
            Text("Hassan Mehmood"),
            Text("https://zahidaz.com"),
          ],
        ),
      ),
    );
  }
}
