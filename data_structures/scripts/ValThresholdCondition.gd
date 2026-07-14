##
extends Condition

class_name ValThresholdCondition

enum compare_operator {
    LESS,
    LESS_EQUAL,
    EQUAL,
    GREATER_EQUAL,
    GREATER,
    NOT_EQUAL
}

## The threshold the val can't cross.
var threshold

##
func _init(trigger:Signal, threshold, compare_operator) -> void:
    super()
    