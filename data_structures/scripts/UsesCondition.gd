## Condition for when an object NumUses.uses reaches a given threshold.
extends ConditionalStatementCondition

class_name UsesCondition

## val .uses should be for the condition to be valid.
var uses_thres:int

##
func _init(uses_thres:int, conditional_statement:Array, name_signal:Signal=Signal()) -> void:
    super(conditional_statement, name_signal)
    self.uses_thres = uses_thres

##
func evaluate(event:Event=null) -> bool:
    assert(event is NumUsesChanged, "Invalid param: expected: UsesCondition.evaluate(event) event = NumUsesChanged, actual: event = " + str(typeof(event)))
    var right:int = event.uses_obj.uses
    
    return con_func.call(uses_thres, right)
    