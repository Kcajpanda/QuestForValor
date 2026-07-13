## Ultimate Source of truth and controller for turn numbers. Signals current turn.
extends Resource

class_name TurnManager


## Stores Current Turn Number.
var curr_turn:int


## Ultimate Source of truth and controller for turn numbers. Signals current turn.
func _init() -> void:
    self.curr_turn = 0

## Advances to the next turn and emits the current turn number through turn_start().
func next_turn() -> void:
    curr_turn +=1
    EventBus.turn_start.emit(curr_turn)





"""

Event Bus (own signal)  {concept} System tracks every => emit signl with relevenat data => object that was given EventBus.specific_signal_name recices it asn acts

You need to build system that track everything, thy user / you needs to write the custom event classes that listen fpr those combinations, emit again that other thinsg listen to.


"""