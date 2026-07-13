## Ultimate parent class for anything where a condition needs to be met, how or what triggers is_met is determined in the subclasses.
extends Resource

class_name Condition

## Whether the con has been met.
var is_met:bool
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
    return is_met

## Resets .is_met to true.
func reset() -> void:
    is_met = false
    self.was_reset.emit()