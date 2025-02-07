
import 'dart:core';

enum ColumnType {
  integer,
  text,
  date,
  boolean,
  bolb,
  real,
  numeric,
  nullType;

  @override
  String toString() {
    switch (this) {
      case ColumnType.integer || ColumnType.boolean:
        return 'INTEGER';
      // case ColumnType.text || ColumnType.date:
      //   return 'TEXT';
      case ColumnType.bolb:
        return 'BLOB';
      case ColumnType.real:
        return 'REAL';
      case ColumnType.numeric:
        return 'NUMERIC';
      case ColumnType.nullType:
        return 'NULL';
      default:
        return 'TEXT';
    }
  }
}



// class ColumnType{
//   static ColumnType INTEGER = null;
//   static late ColumnType TEXT;
//
//   static String NULL = 'null';
//   // static String INT = 'INT';
//   // static String INTEGER = 'INTEGER';
//   // static String TINYINT = 'TINYINT';
//   // static String SMALLINT = 'SMALLINT';
//   // static String MEDIUMINT = 'MEDIUMINT';
//   // static String BIGINT = 'BIGINT';
//   // static String UNSIGNED_BIG_INT = 'UNSIGNED BIG INT';
//   // static String INT2 = 'INT2';
//   // static String INT8 = 'INT8';
//   static String REAL = 'REAL';
//   // static String TEXT = 'TEXT';
//   static String BLOB = 'BLOB';
//   static String BOOLEAN = 'INTEGER';
//   static String DATE = 'TEXT';
//   static String NUMERIC = 'NUMERIC';
//
// }