# Sqflite Easy Query
A new Flutter project for easy sqlite queries for beginner who did not know how to write queries.

## Open Issues to Github
🤔️ You can open issues to [github repository](https://github.com/hassan005004/sqflite-easy-queries/issues)

## Important
⚠️ If your version is below 0.0.8. You need to pass all values for update event id. Also you have to make every variable nullable in model class\
⚠️ It is recommended to use version:1.0.0 or above

## 👉 Step One: Only for version below 0.0.8 Extend with AzSqflite and Add table name to Model Class
you can compare with sample model class [click here](https://github.com/hassan005004/sqflite-easy-queries/blob/main/example/lib/models/UserModel.dart)\
Only for version:0.0.8 and below
```
  class UserDbModel extends AzSqflite{
    String tableName = 'users';
    .....
  }
```

## 👉 Step Second: Migrations
You need to make table modifications queries as follow

### ▪ Example of create table
Note: Primary key or autoincrement only use for one column in a table otheriwse you will get expectation\
Note2: to create table atleast one column is required using method addColumn()\
version:0.0.8 or Above
```
  await AzSqflite().table('users')
  .addColumn(name: "column_name_one", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
  .addColumn(name: "column_name_two", type: ColumnType.text, isNUll: true)
  .execute();
```
Below version:0.0.8
```
  await UserDbModel()
  .addColumn(name: "column_name_one", type: ColumnType.integer, isPrimaryKey: true, isAutoIncrement: true)
  .addColumn(name: "column_name_two", type: ColumnType.text, isNUll: true)
  .execute();
```

### ▪ Example of drop table
A table can be drop by this method dropTable()
version:0.0.8 or Above
```
  await AzSqflite().table('users').dropTable().execute();
```
Below version:0.0.8
```
  await UserDbModel().dropTable().execute();
```

### ▪ Example of add columns in table
To add column to existing table you need to use method addColumn()
version:0.0.8 or Above
```
  await AzSqflite().table('users')
  .addColumn(name: "column_name_three", type: ColumnType.text, isNUll: true)
  .execute();
```
Below version:0.0.8
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
version:0.0.8 or Above
```
  await AzSqflite().table('users')
  .renameColumn(oldName: "column_name_four", newName: "column_name_four")
  .execute();
```
Below version:0.0.8
```
  await UserDbModel()
  .renameColumn(oldName: "column_name_four", newName: "column_name_four")
  .execute();
```

## 👉 Step Third: Tables Supported Queries Actions
Here are some sample queries that you can use
### ▪ Insert Record
version:0.0.8 or Above
```
  AzSqflite().table('users').insert({"name": "name", "fatherName": "father"});
```
Below version:0.0.8
```
  UserDbModel(name: "name", fatherName: "father").insert();
```
Save Method [Model Cla](https://github.com/hassan005004/sqflite-easy-queries/blob/main/example/lib/models/UserNewModel.dart)
```
if record exist update otherwise create new 
UserNewModel user = await UserNewModel().where('id', 1).first();
user.name = 'hassan3';
await user.save();
```
### ▪ Update Record
⚠️ You need to pass all values for update. But i will fix this issue soon
version:0.0.8 or Above
```
  AzSqflite().table('users').where("id", 1).update({"name": "name", "fatherName": "father"});
```
Below version:0.0.8
```
  UserDbModel(id: 1, name: "name", fatherName: "father").where("id", 1).update();
```

### ▪ Delete Record
version:0.0.8 or Above
```
  AzSqflite().table('users').where("id", 1).delete();
```
Below version:0.0.8
```
  UserDbModel().delete();
```

### ▪ Get Record
version:0.0.8 or Above
```
  AzSqflite().table('users').get();
```
Below version:0.0.8
```
  UserDbModel().get();
```

### ▪ Count Record
version:0.0.8 or Above
```
  AzSqflite().table('users').count();
```
Below version:0.0.8
```
  UserDbModel().count();
```

### ▪ Pluck Record
version:0.0.8 or Above
```
  AzSqflite().table('users').pluck('column_name');
```
Below version:0.0.8
```
  UserDbModel().pluck('column_name');
```

## 👉 Step Four: Handle output of instance
You can use get query instance as
version:0.0.8 or Above
```
await AzSqflite().table('users').get().queryResult;

or

AzSqflite().table('users').get().queryResult.then((value){
    print(value);
});
```
Below version:0.0.8
```
await UserDbModel().get().queryResult;

or

UserDbModel().get().queryResult.then((value){
    print(value);
});
```

### ▪ Available Methods that can apply on Query
version:0.0.8 or Above
```
    await AzSqflite().table('users')
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
        // .groupBy('column_name')
        // .skip(1)
        // .limit(2)
        // .page(2)
        .get();
```
Below version:0.0.8
```
    await UserDbModel()
        // .joining('INNER JOIN table_name_2 ON table_name.id = table_name_2.id')
        ...
        ...
        ...
        // .page(2)
        .get();
```

Regards,
<br />
Hassan Mehmood
<br />
https://zahidaz.com