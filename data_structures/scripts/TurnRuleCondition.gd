##
extends Condition

class_name TurnRuleCondition

## The turn rule that decides this condition.
var turn_rule:TurnRule

##
func _init(turn_rule:TurnRule) -> void:
    super()
    self.turn_rule = turn_rule
    TurnBus.turn_start.connect(_check_turn_rule)

## Called whenever a new turn is signalled, checks whether the rule is met
func _check_turn_rule(event:TurnStart) -> void:
    return self.turn_rule.is_apply_time(event.turn_num, event.phase)

func is_turn_rule_met(start_turn:int, curr_turn:int) -> bool:
    var is_time:bool = self.turn_rule.is_apply_time(turn_num, event.phase)