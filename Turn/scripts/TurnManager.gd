## Ultimate Source of truth and controller for turn numbers. Signals current turn.
extends Resource

class_name TurnManager

## The various phases of the turn.
enum state { PLAYER, ENEMY, NEUTRAL }


## Stores the current phase.
var phase:state
## Stores current turn number.
var turn_num:int


## Ultimate Source of truth and controller for turn numbers. Signals current turn.
func _init() -> void:
    self.turn_num = 0
    phase = state.PLAYER

## Based on phase logic it advances the phase and or turn and signals it.
func next() -> void:
    match phase:
        state.PLAYER:
            phase = state.ENEMY
            TurnBus.phase_start.emit(PhaseStart.new(turn_num, phase))
        state.ENEMY:
            phase = state.NEUTRAL
            TurnBus.phase_start.emit(PhaseStart.new(turn_num, phase))
        state.NEUTRAL:
            phase = state.PLAYER
            turn_num +=1
            TurnBus.turn_start.emit(TurnStart.new(turn_num, phase))
            TurnBus.phase_start.emit(PhaseStart.new(turn_num, phase))

"""

Event Bus (own signal)  {concept} System tracks every => emit signl with relevenat data => object that was given EventBus.specific_signal_name recices it asn acts

You need to build system that track everything, thy user / you needs to write the custom event classes that listen fpr those combinations, emit again that other thinsg listen to.


"""