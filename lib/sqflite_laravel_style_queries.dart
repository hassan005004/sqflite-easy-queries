library sqflite_laravel_style_queries;

import 'package:path/path.dart' as path;
// import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../helper/models/column_types.dart';

const dbname = "zahidaz_dot_com";

IndexOfNth(String str, String value, int nth)
{
  if (nth < 0)
    return;

  int offset = str.indexOf(value);
  for (int i = 0; i < nth; i++)
  {
    if (offset == -1) return -1;
    offset = str.indexOf(value, offset + 1);
  }

  return offset;
}

class AzSqflite{

  late Database db;
  String db_name = dbname;

  AzSqflite() :
        select_paramters = '*',
        tableName = 'table', join_statement = '',
        where_conditions = '', group_by_sorting = '',  order_by_sorting = '', limit_result = '', offset = '', skipped_value = 1,
        statement = '', queryResult = [{}], geted = [], plucked = [],
        excute_trigger = 'add_column', add_column = '', rename_column = '', drop_column = '', rename_table = '';


  String select_paramters;
  String tableName;
  String join_statement;

  String where_conditions; int whereCallback = 0;
  String order_by_sorting;
  String group_by_sorting;
  String limit_result;
  String offset; int skipped_value;// skip result
  String statement;

  dynamic queryResult;
  dynamic plucked;
  dynamic geted;

  String excute_trigger;
  String add_column;
  String rename_column;
  String drop_column;
  String rename_table;

  //
  // AzSqflite hasOne(AzSqflite model, key, foreignKey){
  //   // model.where(foreignKey)
  //   // print(1);
  //   return this;
  // }
  // AzSqflite withHasOne({table, key, foreignKey}){
  //   return this;
  // }

  // Use to make statement.
  AzSqflite select(List list){
    select_paramters = list.join(', ');
    return this;
  }
  AzSqflite table(String table){
    tableName = table;
    return this;
  }
  AzSqflite joining(String join){
    if(join_statement == ''){
      join_statement = join;
      return this;
    }

    join_statement += join;
    return this;
  }
  AzSqflite where(col, value, {operator = "=", callbackLevel = 0}){
    whereFunc('AND', col, operator, value, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite orWhere(col, value, {operator = "=", callbackLevel = 0}){
    whereFunc("OR", col, operator, value, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite whereIn(String col, List list, {callbackLevel = 0}){
    whereInFunc('AND', col, list, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite orWhereIn(String col, List list, {callbackLevel = 0}){
    whereInFunc('OR', col, list, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite whereNotIn(String col, List list, {callbackLevel = 0}){
    whereNotInFunc('AND', col, list, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite whereBetween(String col, List list, {callbackLevel = 0}){
    whereBetweenFunc('AND', col, list, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite orWhereBetween(String col, List list, {callbackLevel = 0}){
    whereBetweenFunc('OR', col, list, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite whereNull(String col, {callbackLevel = 0}){
    whereNulFunc('AND', col, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite orWhereNull(String col, {callbackLevel = 0}){
    whereNulFunc('OR', col, callbackLevel: callbackLevel);
    return this;
  }
  AzSqflite whereCallBack(calss){
    where_conditions += calss.where_conditions;
    return this;
  }
  AzSqflite groupBy(col){
    if(group_by_sorting == ''){
      group_by_sorting = 'GROUP BY $col ';
    }else{
      group_by_sorting += ', $col ';
    }
    return this;
  }
  AzSqflite orderBy(col, order){
    if(order_by_sorting == ''){
      order_by_sorting = 'ORDER BY $col $order ';
    }else{
      order_by_sorting += ', $col $order ';
    }
    return this;
  }
  AzSqflite limit(int number){
    if(limit_result == ''){
      limit_result = 'Limit $number';
    }
    return this;
  }
  AzSqflite skip(int number){
    // if(offset == ''){
    offset = 'OFFSET $number';
    skipped_value = number;
    // }
    return this;
  }
  AzSqflite page(int number){
    // int page = number <= 1 ? 1 : number;
    // if(page > 1){
    String offset_caculate = ((number-1) * skipped_value).toString();
    offset = 'OFFSET $offset_caculate';
    // }
    return this;
  }

  // calling statement
  count({column = '*'}) {
    select_paramters = 'COUNT($column) as count';
    queryResult = callQuery();
    return queryResult;
    // return this;
  }
  get() {
    // return get2();
    // return 1;
    dynamic queryResult = callQuery();
    return queryResult;
  }
  first() async {
    // return get2();
    // return 1;
    dynamic queryResult = await callQuery();
    if (queryResult.isNotEmpty) {
      return fromJson(queryResult.first);
      print(queryResult.first);
    } else {
      print('No record found');
    }
    return this;
  }


  // get3() async {
  //   this.select([
  //           "users.id as user_id",
  //           "user_books.id as user_books_id"
  //        ])
  //       .joining("INNER JOIN user_books ON users.id = user_books.id");
  //   await this.callQuery();
  //
  //   return [];
  // }

//   get2() async {
//     // print("users 4");
//     var db = await openDatabase(db_name);
//     // print("users 3");
//     // print("users 2");
//
//     String table = "users";
//     String joinTable = "user_books";
//     // String key = "id";
//     // String foreignKey = "user_id";
//     String joinKeyOne = joinTable + ".user_id";
//     String joinKeyTwo = table + ".id";
//
//     // get all columns from user_books
//     List<Map<String, dynamic>> columns = await db.rawQuery('PRAGMA table_info(user_books)');
//     // List columnNames = columns.map((column) => 'user_books.' + column['name'] + ' as user_books_' + column['name']).toList();
//     // String selectStmt = columnNames.join(",");
//
// //     List<Map<String, dynamic>> users22 = await db.rawQuery(
// //         '''
// // SELECT * FROM users;
// //           ''');
// //     List<Map<String, dynamic>> users22 = await db.rawQuery(
// //         '''SELECT *, GROUP_CONCAT(CONCAT(user_books.id,',',user_books.name), ',') as parts
// //               FROM $table
// //               INNER JOIN $joinTable ON $joinKeyOne = $joinKeyTwo
// //           ''');
// //     print(users22);
//
//
//     // List<Map<String, dynamic>> users22 = await db.rawQuery(
//     //     '''SELECT users.id as users_id, user_books.id as user_books_id
//     //           FROM $table
//     //           LEFT JOIN $joinTable ON $joinKeyOne = $joinKeyTwo
//     //           LIMIT 2
//     //       ''');
//
//     // List<Map<String, dynamic>> userBooksMap = [];
//
//     List<Map<String, dynamic>> results = [];
//
//
//
//     createJsonObject(json, columns){
//       Map<String, dynamic> map = {};
//       for(final column in columns){
//          map[column] = json[column];
//       }
//       return map;
//     }
//
//     int i = 0;
//     int ii = 0;
//     final users_table = await callQuery(); //await db.rawQuery('''SELECT * FROM users''');
//     for (final user in users_table) {
//       ii = 0;
//       dynamic newUser = createJsonObject(user, ["id", "name", "father_name"]);
//       results.insert(i,newUser);
//       final id = user['id'];
//       final user_books_table = await db.rawQuery('''SELECT * FROM user_books where user_id = $id''');
//       for (final user_book in user_books_table) {
//         dynamic newUser = createJsonObject(user_book, ["id", "name", "user_id"]);
//         if(results[i]["user_books"] == null){
//           results[i]["user_books"] = [];
//         }
//         results[i]["user_books"].add(newUser);
//
//         final id = user_book['user_id'];
//         final users_table = await db.rawQuery('''SELECT * FROM users where id = $id''');
//         for (final user in users_table) {
//           dynamic newUser = createJsonObject(user, ["id", "name"]);
//           if(results[i]["user_books"][ii]["user"] == null){
//             results[i]["user_books"][ii]["user"] = [];
//           }
//           results[i]["user_books"][ii]["user"].add(newUser);
//           ++ii;
//         }
//       }
//       ++i;
//     }
//
//
//     return results;
//     // final List<Map<dynamic, dynamic>> usersWithBooks = [];
//     //
//     // // has many
//     // int i = 0;
//     // int many = 0;
//     // Map<dynamic, dynamic> usersWithBook2 = {};
//     // for (final user in users22) {
//     //   Map<dynamic, dynamic> usersWithBook = {};
//     //   for(final u in user.keys){
//     //     if (u.contains(joinTable)) {
//     //       ++many;
//     //       if(usersWithBook[joinTable] == null){
//     //         usersWithBook[joinTable] = [];
//     //       }
//     //
//     //       if(usersWithBook[joinTable].length == 0){
//     //         usersWithBook2 = {};
//     //       }
//     //
//     //       String k = u.replaceAll(joinTable+"_", "");
//     //       usersWithBook2[k] = user[u];
//     //       usersWithBook[joinTable].add(usersWithBook2);
//     //
//     //     } else {
//     //       many = 0;
//     //       usersWithBook2 = {};
//     //       usersWithBook[u] = user[u];
//     //     }
//     //   }
//     //   usersWithBooks.add(usersWithBook);
//     //   ++i;
//     // }
//     // print(usersWithBooks);
//
//     // has one
//     // int i = 0;
//     // for (final user in users22) {
//     //   Map<dynamic, dynamic> usersWithBook = {};
//     //   for(final u in user.keys){
//     //     if (u.contains(joinTable)) {
//     //       Map<dynamic, dynamic> usersWithBook2 = {};
//     //       if(usersWithBook[joinTable] == null){
//     //         usersWithBook[joinTable] = {};
//     //       }
//     //       String k = u.replaceAll(joinTable+"_", "");
//     //       usersWithBook2[k] = k;
//     //       usersWithBook[joinTable][k] = k;
//     //     } else {
//     //       usersWithBook[u] = user[u];
//     //     }
//     //   }
//     //   usersWithBooks.add(usersWithBook);
//     //   ++i;
//     // }
//     // print(usersWithBooks);
//     // return [];
//     // print(statement);
//     // try {
//     //   await db.transaction((txn) async {
// //         print("users 1");
// //       List<Map<String, dynamic>> users = await db.rawQuery('''
// //     SELECT u1.name AS name1, u2.name as name2
// //     FROM users u1
// //     INNER JOIN users u2 ON u2.id = u1.id
// // ''');
// //         print(users);
// //
// //     List<Map<String, dynamic>> dynamicRows = [];
// //     for (var user in users) {
// //
// //       Map<String, dynamic> dynamicRow = {};
// //       user.forEach((key, value) {
// //         if (value is String) {
// //           dynamicRow[key] = value;
// //         }
// //       });
// //       dynamicRow["books"] = "books";
// //
// //       dynamicRows.add(dynamicRow);
// //
// //     }
// //
// //     print(dynamicRows);
//
//       // });
//     // } catch (e) {
//     //   // Handle exceptions if needed
//     //   print('Transaction failed: $e');
//     // }
//   }
  pluck(String key) {
    queryResult = callPluck(key);
    return queryResult;
    // plucked.then((id) => print("Id that was loaded: $id"));
    // return this;
  }
  delete(){
    queryResult = callDeleteQuery();
    return queryResult;
    // return this;
  }

  Map<String, dynamic> toJson() => {};
  AzSqflite fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson() must be implemented by the subclass');
  }

  insert(jsonObj){
    if(jsonObj != null){
      queryResult = callInsertQuery([jsonObj]);
    }else{
      queryResult = callInsertQuery([toJson()]);
    }
    return queryResult;
    // return this;
  }

  // Save method that uses the model's JSON representation.


  save() async {
    // Convert the current model instance to JSON.
    Map<String, dynamic> attributes = toJson();
    var db = await openDatabase(db_name);

    if (attributes.containsKey('id') && attributes['id'] != null) {
      // If an id exists, update the record.
      where('id', attributes['id']);
      await callUpdateQuery(attributes);
    } else {
      // If no id exists, insert a new record and capture the new id.
      int insertedId = await callInsertQuery([attributes]);
      attributes['id'] = insertedId;
    }

    // Now fetch the latest record from the database using the id.
    List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT * FROM $tableName WHERE id = ?',
        [attributes['id']]
    );

    if (result.isNotEmpty) {
      // Use fromJson() to convert the record into a model instance.
      return fromJson(result.first);
    }

    // If no record is found, return the current instance.
    return this;
  }


  // AzSqflite insertArray(){
  //   queryResult = callInsertQueryArray([toJson()]);
  //   return this;
  // }

  // AzSqflite insert(Map<String, dynamic> map){
  //   queryResult = callInsertQuery([map]);
  //   return this;
  // }

  // AzSqflite insertArray(List<Map<String, dynamic>> map){
  //   queryResult = callInsertQueryArray(map);
  //   return this;
  // }

  AzSqflite update(jsonObj){
    if(jsonObj != null){
      queryResult = callUpdateQuery(jsonObj);
    }else{
      queryResult = callUpdateQuery(toJson());
    }
    return this;
  }
  // AzSqflite update(Map<String, dynamic> map){
  //   queryResult = callUpdateQuery(map);
  //   return this;
  // }


  AzSqflite addColumn({required name, required ColumnType type, isNull = false, isPrimaryKey = false, isAutoIncrement = false}){
    excute_trigger = 'add_column';

    add_column += '$name $type';

    if(isPrimaryKey == true){
      add_column += ' PRIMARY KEY';
    }

    if(isAutoIncrement == true){
      add_column += ' AUTOINCREMENT';
    }

    if(isNull == false){
      add_column += ' NOT NULL';
    }else{
      add_column += ' NULL';
    }

    add_column += ', ';


    return this;
  }
  AzSqflite renameColumn({required oldName, required newName}){
    excute_trigger = 'rename_column';

    rename_column += '$oldName to $newName';

    rename_column += ', ';

    return this;
  }
  AzSqflite dropColumn({required name}){
    excute_trigger = 'drop_column';

    drop_column += '$name';
    drop_column += ', ';

    return this;
  }
  AzSqflite renameTable({required oldName, required newName}){
    excute_trigger = 'rename_table';

    rename_table = 'ALTER TABLE $oldName RENAME TO $newName';
    rename_table += ', ';

    return this;
  }
  AzSqflite dropTable() {
    excute_trigger = 'drop_table';
    return this;
  }

  Future<AzSqflite> execute() async {
    var db = await openDatabase(db_name);

    if(excute_trigger == 'add_column'){
      // remove last comma
      add_column = add_column.substring(0, add_column.lastIndexOf(", "));

      List tables = await db.rawQuery('SELECT * FROM sqlite_master WHERE name="$tableName";');

      if(tables.isEmpty){
        statement = 'CREATE TABLE IF NOT EXISTS $tableName ($add_column)';
        db.execute(statement);
        // print(tables[0]["name"]);
      }else{
        List arr = add_column.split(',');

        db.rawQuery('BEGIN TRANSACTION;');
        for(int i = 0; i < arr.length; ++i){

          String column = arr[i].trim().split(" ")[0];
          bool b = await isColumnExists(db, column);
          if(b == false){
            statement = 'ALTER TABLE $tableName ADD COLUMN ${arr[i]}';
            db.execute(statement);
          }
        }
        db.rawQuery('COMMIT;');
      }



    }
    else if(excute_trigger == 'rename_column'){
      // remove last comma
      rename_column = rename_column.substring(0, rename_column.lastIndexOf(", "));

      List arr = rename_column.split(',');

      db.rawQuery('BEGIN TRANSACTION;');
      for(int i = 0; i < arr.length; ++i){

        List a;
        a = arr[i].split(" ");
        String old_column = a[0].toString();
        String statement_check_column = "PRAGMA table_info($tableName)";
        List list = await db.rawQuery(statement_check_column);
        list = list.where((element) => element["name"] == old_column).toList();
        if(list.isNotEmpty){
          statement = 'ALTER TABLE $tableName RENAME COLUMN ${arr[i]}';
          db.execute(statement);
          // print('SQFLITE EASY >>> column renamed successfully');
        }else{
          // print('SQFLITE EASY >>> column $old_column not exists');
        }

      }
      db.rawQuery('COMMIT;');

    }
    else if(excute_trigger == 'drop_column'){
      // remove last comma
      drop_column = drop_column.substring(0, drop_column.lastIndexOf(", "));

      List arr = drop_column.split(',');

      db.rawQuery('BEGIN TRANSACTION;');
      for(int i = 0; i < arr.length; ++i){
        statement = 'ALTER TABLE `$tableName` DROP `${arr[i]}`;';
        db.execute(statement);
      }
      db.rawQuery('COMMIT;');

    }
    else if(excute_trigger == 'drop_table'){
      await db.execute("DROP TABLE IF EXISTS ${tableName}");

      // print('SQFLITE EASY >>> already drop table $tableName or not exists');
    }else if(excute_trigger == 'rename_table'){
      rename_table = rename_table.substring(0, rename_table.lastIndexOf(", "));

      List arr = rename_table.split(',');

      db.rawQuery('BEGIN TRANSACTION;');
      for(int i = 0; i < arr.length; ++i){
        statement = arr[i];
        db.execute(statement);
      }
      db.rawQuery('COMMIT;');

    }

    return this;
  }

  isColumnExists(db, column) async {
    String statement_check_column = "PRAGMA table_info($tableName)";
    List list = await db.rawQuery(statement_check_column);
    list = list.where((element) => element["name"] == column).toList();
    if(list.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }
  removeAllTables() async {
    var db = await openDatabase(db_name);
    List all_tables = await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
    for(int i = 1; i < all_tables.length; ++i){
      if(all_tables[i]['name'] != "sqlite_sequence"){
        await db.execute("DROP TABLE IF EXISTS ${all_tables[i]['name']}");
        db.execute(statement);
      }
    }
    return this;
  }

  // helping in making statement
  AzSqflite whereFunc(type, col, operator, value, {callbackLevel = 0}){
    if(callbackLevel == 0 && where_conditions == ''){
      where_conditions = 'WHERE $col $operator "$value" ';
      return this;
    }

    if(callbackLevel == 0){
      where_conditions += '$type $col $operator "$value" ';
      return this;
    }

    int postitonOfBracket = IndexOfNth(where_conditions, ')', callbackLevel - 1);
    if(postitonOfBracket <= 0){
      where_conditions += '$type ($col $operator "$value") ';
      return this;
    }

    String ss = where_conditions;
    where_conditions = ss.substring(0, postitonOfBracket) + " $type $col $operator $value " + ss.substring(postitonOfBracket, ss.length);

    // print(where_conditions);
    return this;
  }
  AzSqflite whereInFunc(type, col, _list, {callbackLevel = 0}){
    String list = "( " + _list.join(', ') + " )";
    if(callbackLevel == 0 && where_conditions == ''){
      where_conditions = 'WHERE $col IN "$list" ';
      return this;
    }

    if(callbackLevel == 0){
      where_conditions += '$type $col IN "$list" ';
      return this;
    }

    int postitonOfBracket = IndexOfNth(where_conditions, ')', callbackLevel - 1);
    if(postitonOfBracket <= 0){
      where_conditions += '$type ($col IN "$list") ';
      return this;
    }


    String ss = where_conditions;
    where_conditions = ss.substring(0, postitonOfBracket) + " $type $col IN '$list' " + ss.substring(postitonOfBracket, ss.length);

    // print(where_conditions);
    return this;
  }
  AzSqflite whereNotInFunc(type, col, _list, {callbackLevel = 0}){
    String list = "( " + _list.join(', ') + " )";
    if(callbackLevel == 0 && where_conditions == ''){
      where_conditions = 'WHERE $col NOT IN "$list" ';
      return this;
    }

    if(callbackLevel == 0){
      where_conditions += '$type $col IN "$list" ';
      return this;
    }

    int postitonOfBracket = IndexOfNth(where_conditions, ')', callbackLevel - 1);
    if(postitonOfBracket <= 0){
      where_conditions += '$type ($col IN "$list") ';
      return this;
    }


    String ss = where_conditions;
    where_conditions = ss.substring(0, postitonOfBracket) + " $type $col IN '$list' " + ss.substring(postitonOfBracket, ss.length);

    // print(where_conditions);
    return this;
  }
  AzSqflite whereBetweenFunc(type, col, _list, {callbackLevel = 0}){
    String val1 = _list[0];
    String val2 = _list[1];
    if(callbackLevel == 0 && where_conditions == ''){
      where_conditions = 'WHERE $col BETWEEN "$val1" AND "$val2"';
      return this;
    }

    if(callbackLevel == 0){
      where_conditions += '$type $col BETWEEN "$val1" AND "$val2" ';
      return this;
    }

    int postitonOfBracket = IndexOfNth(where_conditions, ')', callbackLevel - 1);
    if(postitonOfBracket <= 0){
      where_conditions += '$type ($col IN BETWEEN "$val1" AND "$val2") ';
      return this;
    }

    String ss = where_conditions;
    where_conditions = ss.substring(0, postitonOfBracket) + " $type $col BETWEEN '$val1' AND  '$val2' " + ss.substring(postitonOfBracket, ss.length);

    // print(where_conditions);
    return this;
  }
  AzSqflite whereNulFunc(type, col, {callbackLevel = 0}){
    if(callbackLevel == 0 && where_conditions == ''){
      where_conditions = 'WHERE $col IS NULL';
      return this;
    }

    if(callbackLevel == 0){
      where_conditions += '$type $col IS NULL ';
      return this;
    }

    int postitonOfBracket = IndexOfNth(where_conditions, ')', callbackLevel - 1);
    if(postitonOfBracket <= 0){
      where_conditions += '$type ($col IS NULL) ';
      return this;
    }


    String ss = where_conditions;
    where_conditions = ss.substring(0, postitonOfBracket) + " $type $col IS NULL " + ss.substring(postitonOfBracket, ss.length);

    // print(where_conditions);
    return this;
  }
  callQuery() async{
    var db = await openDatabase(db_name);
    statement = 'SELECT $select_paramters FROM $tableName $join_statement $where_conditions $group_by_sorting $order_by_sorting $limit_result $offset';

    // print(statement);
    return await db.rawQuery(statement);
  }
  callQueryRelationShipHasOne(tableName, col1, col2) async{
    var db = await openDatabase(db_name);
    statement = 'SELECT * FROM $tableName WHERE $col1 = $col2';

    // print(statement);
    return await db.rawQuery(statement);
  }

  Future callDeleteQuery() async{
    // delete not support $offset > confirm
    // delete not support $order_by_sorting, $limit_result > not confirm
    var db = await openDatabase(db_name);
    statement = 'DELETE FROM $tableName $where_conditions ';
    // print(statement);
    return await db.rawQuery(statement);
  }

  Future callInsertQuery(map) async{
    // print(map);
    String columns = '';

    var buffer = StringBuffer();

    for(int i = 0; i < map.length; ++i){
      int start = 0;
      int end = map[i].length;
      // print("end");
      // print(end);
      map[i].forEach((k,v) {

        // if(k.toString().contains("'")){
        //   k = k.replaceAll("'", "\\'");
        // }
        //
        // if(v.toString().contains("'")){
        //   v = v.replaceAll("'", "\\'");
        // }

        if(i == 0){
          columns += k + ',';
        }
        // if (buffer.isNotEmpty) {
        //   buffer.write(",\n");
        // }

        if(start == 0){
          buffer.write('("');
        }

        buffer.write(v);

        ++start;

        if(start != end){
          buffer.write('", "');
        }else{
          buffer.write('" ');
        }

        if(start == end){
          buffer.write('),');
          // buffer.write(",'')");
          // buffer.write(",\n");
        }

      });
    }
    // map.forEach((k,v) {
    //   print(k);
    //
    //   if (buffer.isNotEmpty) {
    //     buffer.write(",\n");
    //   }
    //   // buffer.write(k.name);
    //   // buffer.write("', '");
    //   // buffer.write(k.real_url);
    //   // buffer.write("', '");
    //   // buffer.write(k.category);
    //   // buffer.write("', '");
    //   // buffer.write(k.desc);
    //   // buffer.write("', '");
    //   // buffer.write(k.logo);
    //   // buffer.write("', '");
    //   // buffer.write(k.is_deal);
    //   // buffer.write("', '");
    //   // buffer.write(k.toppartner);
    //   // buffer.write("', '");
    //   // buffer.write(k.countrys);
    //   // buffer.write("', '");
    //   // buffer.write(k.cashback);
    //   // buffer.write("', '");
    //
    // });
    String bufferString = buffer.toString();
    bufferString = bufferString.substring(0,bufferString.length - 1);

    String columnsString = columns.substring(0,columns.length - 1);
    columnsString = "($columnsString)";
    // print(columns);
    // print(bufferString);
    // insert all records
    var db = await openDatabase(db_name);
    // await db.rawInsert("INSERT INTO `$tableName` $columnsString VALUES $bufferString;");
    int insertedId = await db.rawInsert("INSERT INTO `$tableName` $columnsString VALUES $bufferString;");
    return insertedId;
    // print(a);
    // await db.close();
  }

  Future callInsertQueryArray(map) async{
    // print(map);
    String columns = '';

    var buffer = StringBuffer();

    for(int i = 0; i < map.length; ++i){
      int start = 0;
      int end = map[i].length;
      // print("end");
      // print(end);
      map[i].forEach((k,v) {

        // if(k.toString().contains("'")){
        //   k = k.replaceAll("'", "\\'");
        // }
        //
        // if(v.toString().contains("'")){
        //   v = v.replaceAll("'", "\\'");
        // }

        if(i == 0){
          columns += k + ',';
        }
        // if (buffer.isNotEmpty) {
        //   buffer.write(",\n");
        // }

        if(start == 0){
          buffer.write('("');
        }

        buffer.write(v);

        ++start;

        if(start != end){
          buffer.write('", "');
        }else{
          buffer.write('" ');
        }

        if(start == end){
          buffer.write('),');
          // buffer.write(",'')");
          // buffer.write(",\n");
        }

      });
    }
    // map.forEach((k,v) {
    //   print(k);
    //
    //   if (buffer.isNotEmpty) {
    //     buffer.write(",\n");
    //   }
    //   // buffer.write(k.name);
    //   // buffer.write("', '");
    //   // buffer.write(k.real_url);
    //   // buffer.write("', '");
    //   // buffer.write(k.category);
    //   // buffer.write("', '");
    //   // buffer.write(k.desc);
    //   // buffer.write("', '");
    //   // buffer.write(k.logo);
    //   // buffer.write("', '");
    //   // buffer.write(k.is_deal);
    //   // buffer.write("', '");
    //   // buffer.write(k.toppartner);
    //   // buffer.write("', '");
    //   // buffer.write(k.countrys);
    //   // buffer.write("', '");
    //   // buffer.write(k.cashback);
    //   // buffer.write("', '");
    //
    // });
    String bufferString = buffer.toString();
    bufferString = bufferString.substring(0,bufferString.length - 1);

    String columnsString = columns.substring(0,columns.length - 1);
    columnsString = "($columnsString)";
    // print(columns);
    // print(bufferString);
    // insert all records
    var db = await openDatabase(db_name);
    await db.rawInsert("INSERT INTO `$tableName` $columnsString VALUES $bufferString;");
    // print(a);
    // await db.close();
  }
  Future callUpdateQuery(map) async{
    // print(map);
    String makeSetStatement = 'SET ';

    map.forEach((k,v) {

      makeSetStatement += '"${k}" = "${v}",';

    });


    String makeSetStatementString = makeSetStatement.substring(0,makeSetStatement.length - 1);
    // print(makeSetStatementString);

    // insert all records
    var db = await openDatabase(db_name);
    await db.rawUpdate("UPDATE `$tableName` $makeSetStatementString $where_conditions;");
    // await db.close();
  }
  Future callPluck(key) async{
    plucked = initializeIntValue();
    List list = [];
    await queryResult.then((dynamic output) async {
      for(int i = 0; i < output.length; ++i){
        list.add(output[i][key]);
      }
      return plucked = list;
    });
    return plucked;
    // print(plucked);
  }

  Future<List> initializeIntValue() async {
    return [];
  }

  Future open() async {

    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String _path = path.join(databasesPath, db_name);
    //join is from path package

    db = await openDatabase(_path, version: 1,
        onCreate: (Database database, int version) async {
          // await database.execute('CREATE TABLE IF NOT EXISTS files('
          //     'id INTEGER PRIMARY KEY, '
          //     'data text, ' // path of file
          //     'name text, ' // name of file
          //     'folder text, ' // folder name of file
          //     'file_created_at text, ' // file creation date for filter
          //     'last_opened_at text, ' // date filter for recently open
          // // 'created_at text, ' // record created_date
          //     'open_counts INTEGER not null, ' // counts to open_counts
          //     'recheck INTEGER' // this is helpful to remove delted files from other app
          //     ')');
          // await database.execute('CREATE TABLE IF NOT EXISTS settings('
          //     'id INTEGER not null, '
          //     'play_sound INTEGER not null, '
          //     'play_vibration INTEGER not null,'
          //     'active_counter_id INTEGER not null'
          //     ')');

        });

    await initiateFirstTimeLaunch(db);

    // await db.close();
  }

  Future initiateFirstTimeLaunch(db) async{
    // no need to open db beucase calling this function inside open db functon

    // // get settings if not eixists then it is first time launch and insert setting and counter
    // final res = await db.rawQuery('SELECT * FROM settings LIMIT 1');
    //
    // bool isExist = res.isNotEmpty ? true : false;
    //
    // if(!isExist){
    //   await db.transaction((txn) async {
    //     // default settings
    //     int id1 = await txn.rawInsert('INSERT INTO settings(id, play_sound, play_vibration, active_counter_id) VALUES(1,0,0,1)');
    //     print('inserted1: $id1');
    //   });
    // }

    // await db.close();
  }

  Future<void> deleteDatabase() async {
    var databasesPath = await getDatabasesPath();
    String _path = path.join(databasesPath, db_name);
    databaseFactory.deleteDatabase(_path);
  }

  /**
   * Function for understanding app from ui
   */
  getAllTables() async {
    var db = await openDatabase(db_name);
    return await db.rawQuery('SELECT * FROM sqlite_master ORDER BY name;');
  }
  getAllColumns(table_name) async {
    var db = await openDatabase(db_name);
    String statement_check_column = "PRAGMA table_info($table_name)";
    List list = await db.rawQuery(statement_check_column);
    return list;
  }

  getAllData(table_name) async {
    var db = await openDatabase(db_name);
    List list = await db.rawQuery('SELECT * FROM ${table_name};');
    return list;
  }

}