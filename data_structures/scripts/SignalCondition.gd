## Like a condition but instead the receipt of the event its waiting for is considered meeting the condition.
extends Condition

class_name SignalCondition

##
func _init(name_signal) -> void:
    super(name_signal)