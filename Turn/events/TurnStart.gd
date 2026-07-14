## Event for whenever the turn changes. has .turn_num and .phase.
extends Event

class_name TurnStart

## The current turn number.
var turn_num:int
## Which phase of the turn is active: player, enemy, etc.
var phase:TurnManager.state

## Event for whenever the turn changes. has .turn_num and .phase.
func _init(turn_num:int, phase:TurnManager.state) -> void:
    self.turn_num = turn_num
    self.phase = phase