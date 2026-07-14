## Event representing the change in is_met of a condition. Contains .result which matches .is_met at the time of emission.
extends AnnounceEvent

class_name ConditionIsMetChange

## The is_met val from the condition.
var result:bool
## The condition that changed.
var con:Condition

## Event representing the change in is_met of a condition. Contains .result which matches .is_met at the time of emission.
func _init(result:bool, con:Condition) -> void:
    self.result = result
    self.con = con