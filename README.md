# Sqflite Easy Query
A new Flutter project for easy sqlite queries for beginner who did not know how to write queries.

## 👉 Step One: Extend with MyDb and Add table name to Model Class
you can compare with sample model lib\services\sqlite\models\UserDbModel.dart
```
  class UserDbModel extends SqfliteEasyDb{
    String tableName = 'users';
    .....
  }
```

## 👉 Step Second: Migrations
You need to make table modifications queries as follow

### ▪ Example of create table
Note: Primary key or autoincrement only use for one column in a table otheriwse you will get expectation
Note2: to create table atleast one column is required using method addColumn()
```
  await UserDbModel()
  .addColumn(name: "column_name_one", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
  .addColumn(name: "column_name_two", type: ColumnType.text, isNUll: true)
  .execute();
```

### ▪ Example of drop table
A table can be drop by this method dropTable()
```
  await UserDbModel().dropTable().execute();
```

### ▪ Example of add columns in table
To add column to existing table you need to use method addColumn()
```
  await UserDbModel()
  .addColumn(name: "column_name_three", type: ColumnType.text, isNUll: true)
  .execute();
```

### ▪ Example of delete column in table
```
  // not supported yet
```

### ▪ Example of rename column in table
renameColumn() method is use to rename column mame in a table
```
  await UserDbModel()
  .renameColumn(oldName: "column_name_four", newName: "column_name_four")
  .execute();
```

## 👉 Step Third: Tables Supported Queries Actions
Here are some sample queries that you can use
### ▪ Insert Record
```
  UserDbModel(name: "name", fatherName: "father").insert();
```

### ▪ Update Record
```
  UserDbModel(name: "name", fatherName: "father").where("id", 1).update();
```

### ▪ Delete Record
```
  UserDbModel().delete();
```

### ▪ Get Record
```
  UserDbModel().get();
```

### ▪ Count Record
```
  UserDbModel().count();
```

### ▪ Pluck Record
```
  UserDbModel().pluck('column_name_one');
```

## 👉 Step Four: Handle output of instance
You can use get query instance as
```
await UserDbModel().get().queryResult;

or

UserDbModel().get().queryResult.then((value){
    print(value);
});
```

### ▪ Available Methods that can apply on Query
```
    await UserDbModel()
        // .joining('INNER JOIN table_name_2 ON table_name.id = table_name_2.id')
        // .select(['id','column_name_one']) // select specific column
        // .whereBetween('id', ['1','10']) // accept only two values in array
        // .orWhereBetween('id', ['1','10']) // accept only two values in array
        // .whereIn('id', ['1','2','3'])
        // .orWhereIn('column_name_one', '1', operator: Operator.equal)
        // .whereNotIn('column_name_one', '1', operator: Operator.equal)
        // .where('column_name_one', '1', operator: Operator.equal)
        // .orWhere('column_name_one', '1', operator: Operator.equal)
        // .whereNull(column_name_one)
        // .orderBy('column_name_two', 'DESC')
        // .skip(1)
        // .limit(2)
        // .page(2)
        .get();
```

Regards,
<br />
Hassan Mehmood
<br />
https://zahidaz.com