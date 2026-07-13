## Ultimate parent class for anything where a condition needs to be met, how or what triggers is_met is determined in the subclasses.
extends Resource

class_name Condition

## Whether the con has been met.
var is_met:bool
## Optional signal that can be sued depending on who the MultiCondition is implemented.
signal signal_is_met
## Emit if the Condition is ever reset.
signal was_reset

## Ultimate parent class for anything where a condition needs to be met, how or what triggers is_met is determined in the subclasses.
func _init() -> void:
    is_met = false

## Changes is_met to true.
func con_was_met() -> void:
    is_met = true

## Returns whether the condition has been met, meaning .is_met.
func is_con_met() -> bool:
    self.signal_is_met.emit()
    return is_met

## Resets .is_met to true.
func reset() -> void:
    is_met = false
    self.was_reset.emit()