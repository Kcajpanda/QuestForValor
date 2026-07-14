## Like a Condition but instead of having a one condition it has an array of them . For Conditions that are signal based, they connect to this instance's eval() so they are evaluated immediately.
extends Condition

class_name MultiCondition

## Array of all conditions need for this Trigger to trigger.
var conditions:Array[Condition]

## Like a Condition but instead of having a one condition it has an array of them . For Conditions that are signal based, they connect to this instance's eval() so they are evaluated immediately.
func _init(conditions:Array[Condition], name_signal:Signal=Signal()) -> void:
    super(name_signal)
    self.conditions = conditions

    for con in self.conditions:
        self.connect_to_check_condition(con.signal_is_met_changed)

## Override of parent eval to handle evaluating for this instances multiple conditions.
func evaluate() -> bool:
    for con in conditions:
        if !con.is_con_met():
            return false
    return true

## Overrides parent reset. Runs Condition.reset() on itself and it's child conditions.
func reset() -> void:
    super.reset()

    for con in conditions:
        con.reset()