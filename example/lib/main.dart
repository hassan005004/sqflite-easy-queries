import 'package:flutter/material.dart';
import 'package:example/models/UserModel.dart';
import 'package:sqflite_laravel_style_queries/helper/models/column_types.dart';
import 'package:sqflite_laravel_style_queries/sqflite_laravel_style_queries.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // open database
  await SqfliteEasyDb().open();

  // create database table example
  UserModel()
      .addColumn(name: "id", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
      .addColumn(name: "name", type: ColumnType.text, isNUll: true)
      .addColumn(name: "father_name", type: ColumnType.text, isNUll: true)
      .execute();

  // insert records examples
  UserModel(name: "hassan 1", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
  UserModel(name: "hassan 2", fatherName: "Khawaja Muhammad Asghar Saqi").insert();
  UserModel(name: "hassan 3", fatherName: "Khawaja Muhammad Asghar Saqi").insert();

  // get records example
  print("get all records");
  print(await UserModel().get());

  // update record example
  UserModel(name: "abc").where(UserModel().id, 1).update();
  print("get all records after update");
  print(await UserModel().get());

  // delete all records example
  UserModel().where(UserModel().id, 1).delete();
  print("get all records after delete one");
  print(await UserModel().get());

  // delete all records example
  UserModel().delete();
  print("no record after delete all");
  print(await UserModel().get());

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sqlflite Laravel Style',
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Example of package",),
            Text("Hassan Mehmood"),
            Text("https://zahidaz.com"),
          ],
        ),
      ),
    );
  }
}
