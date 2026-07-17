## Simple class that contains an Array[int] which are the turns the turn rule applies on based input start_turn:int. Serves as a clean return object for the TurnRule class .create_active().
extends Resource

class_name ActiveTurnRule

## Turn the rule starts to apply on.
var start_turn:int
## Turn the rule ends on.
var end_turn:int
## Turns the rule applies on.
var turns:Array[int]

## Simple class that contains an Array[int] which are the turns the turn rule applies on based input start_turn:int. Serves as a clean return object for the TurnRule class .create_active().
func _init(start_turn:int, duration:int, rel_turns:Array[int]) -> void:
    self.start_turn = start_turn
    end_turn = start_turn + duration

    self._gen_abs_apply_turns(rel_turns)

## Return curr_turn == end_turn.
func is_duration_finished(curr_turn:int) -> bool:
    return curr_turn == end_turn

## Based on the relative turns generated from the TurnRule and .start_turn, it generates the turns the active rule applies on. 
func _gen_abs_apply_turns(rel_turns:Array[int]) -> Array[int]:
    turns = []
    for turn_num in rel_turns:
        turns.append(turn_num + start_turn)
    return turns





