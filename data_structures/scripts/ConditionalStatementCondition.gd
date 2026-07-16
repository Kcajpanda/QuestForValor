## Like a Condition but it accepts params to construct a ConditionalStatement subclass. The func returned by the Conditional statement is used to evaluate event data.
extends Condition

class_name ConditionalStatementCondition

## Func callable by .evaluate() to run a saved ConditionalStatement on the fluid event data passed to it.
var con_func:Callable

## Like a Condition but it accepts params to construct a ConditionalStatement subclass. The func returned by the Conditional statement is used to evaluate event data.
func _init(conditional_statement:Array, name_signal:Signal=Signal()) -> void:
    con_func = ConditionalStatement.parse(conditional_statement)
    super(name_signal)

## Override of parent evaluate to the passed in compare_func. This is a sample function to be overridden by child classes.
func evaluate(_event:Event=null) -> bool:
    var right
    var left

    return con_func.call(left, right)