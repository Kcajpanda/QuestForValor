## Child of Condition designed to make its 
extends Condition

class_name ConditionalStatement

enum compare_operator {
    LESS,
    LESS_EQUAL,
    EQUAL,
    GREATER_EQUAL,
    GREATER,
    NOT_EQUAL
}

enum logical_operator { AND, OR, NOT }

## Represents the left side val.
var left
## Represents the conditional operator evaluating the left and right side.
var c_operator:compare_operator
## Represents the right side val.
var right

## Func representing a call to evaluate the conditional statement represented by this object.
var con_statement:Callable

##
func _init(conditional:Array, name_signal:Signal=Signal()) -> void:
    super(name_signal)
    self.validate(conditional)
    con_statement = self.parse()

## Validates input array to make sure its of the proper form.
func validate(conditional:Array) -> void:
    pass

## Parses the validated input that been saved to the instance state and builds a function to return the answer to that conditional statement.
func parse() -> Callable:
    return Callable()

## This children class version of evaluate(). Returns con_statement.call()
func evaluate() -> bool:
    return con_statement.call()