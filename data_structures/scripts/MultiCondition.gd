## Like a Condition but instead of having a one condition it has an array of them where it checks for .is_con_met(). For Conditions that are signal based, they connect to eval() so they are evaluated immediately.
extends Condition

class_name MultiCondition

## Array of all conditions need for this Trigger to trigger.
var conditions:Array[Condition]
## Signal for when all conditions are met.
signal signal_all_con_met

## Like a Condition but instead of having a one condition it has an array of them where it checks for .is_con_met(). For Conditions that are signal based, they connect to eval() so they are evaluated immediately.
func _init(conditions:Array[Condition]) -> void:
    super()
    self.conditions = conditions

    for con in self.conditions:
        if con is SignalLatch:
            con.signal_con_was_met.connect(eval)

## Checks to see if all conditions are met, if so it emits success.
func eval() -> void:
    for con in conditions:
        if con.is_con_met() == false:
            return
    is_met = true
    self.signal_all_con_met.emit(conditions)

## Changes .is_all_con_met and the individual .is_met of each Condition back to false.
func reset() -> void:
    is_met = false

    for con in conditions:
        con.reset()