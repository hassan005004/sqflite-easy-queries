
import 'dart:core';

enum Operator {
  equal,
  notEqual,
  like,
  notLike,
  greaterThan,
  greaterOrEqual,
  lessThan,
  lessOrEqual,
  ;

  @override
  String toString() {
    switch (this) {
      case Operator.equal:
        return '=';
      case Operator.notEqual:
        return '!=';
      case Operator.like:
        return 'like';
      case Operator.notLike:
        return 'notLike';
      case Operator.greaterThan:
        return '>';
      case Operator.greaterOrEqual:
        return '>=';
      case Operator.lessThan:
        return '<';
      case Operator.lessOrEqual:
        return '<=';
      default:
        return '=';
    }
  }
}


