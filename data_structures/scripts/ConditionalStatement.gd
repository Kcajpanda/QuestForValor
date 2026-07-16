## Parent class of a type of constructor for taking in parameters and return func that evaluate params in a set conditional statement.
extends Resource

class_name ConditionalStatement

enum compare_operator {
    LESS,
    LESS_EQUAL,
    EQUAL,
    GREATER_EQUAL,
    GREATER,
    NOT_EQUAL
}

enum logic_operator { AND, OR, NOT }

static func parse(params:Array) -> Callable:
    if len(params) == 1 and  ( params[0] == logic_operator.AND or params[0] == logic_operator.OR):
        return LogicStatement.parse(params[0])
    else:
        return ComparisonStatement.parse(params)