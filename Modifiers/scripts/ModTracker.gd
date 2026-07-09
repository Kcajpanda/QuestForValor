## Data Object used to tracker a single Modifier's life cycle, used by Mod Manager. Signals manager when its time for Modifier (and its own) deletion.
extends Resource

class_name ModTracker

## The Modifier it's tracking.
var mod:Modifier
## In-game turn of Modifier creation.
var start_turn:int
## In-game turn of first Mod application.
var first_apply:int
## In-game current turn. Incremented every call of turn()
var curr_turn:int
## The in-game turn when the modifier will expire.
var end_turn:int
## (In-game) Turns when mod will be applied.
var apply_turns:Array[int]
## Set to 0, used for internal tracking of Modifier.
var rel_start_turn:int
## First time of mod application set to mod.first_apply (which is built around the relavtive system).
var rel_first_apply:int
## Current turn based on relative system (rel_start_turn). Incremented every call of turn()
var rel_curr_turn:int
## The relative turn when the modifier will expire.
var rel_end_turn:int
## (Relative Turn System) Turns when mod will be applied.
var rel_apply_turns:Array[int]
## Stored differnece between Relative and in-game turn systems.
var diff:int

## Creates a ModTracker based on given mod and current in-game turn.
func _init(mod:Modifier, curr_turn:int) -> void:
	self.mod = mod
	self.start_turn = curr_turn
	self.curr_turn = curr_turn
	self.end_turn = self.start_turn + mod.duration 
	
	self.diff = self.end_turn - self.curr_turn
	
	self.rel_start_turn = self.start_turn - diff
	self.rel_first_apply = mod.first_apply
	self.rel_curr_turn =  self.rel_start_turn
	self.rel_end_turn = self.end_turn - diff
	
	self.first_apply = self.rel_first_apply + diff
	
	self._set_apply_turns()

# Main

## called by ModManager to have a single turn run for modifiers, either returns the apply() for the mod or nothing, tracks for deletion and emits the signal when time.
func turn():
	var out = null 
	if rel_curr_turn in rel_apply_turns:
		out = mod
	if is_end_life():
		mod.end_mod.emit(mod.id, curr_turn)
	self._increm_turn()
	return out

# Showing Mod Progress

## (Relative Turn System) Shows current progress of Modifier
func show_rel() -> String:
	return "start: 0, first_apply: " + str(self.rel_first_apply) + "| turn: " + str(rel_curr_turn) + " / " + str(rel_end_turn)

## (In-Game Turn System) Shows current progress of Modifier
func show_abs() -> String:
	return "start: " + str(start_turn) + ", first_apply: " + str(self.first_apply) + "| turn: " + str(curr_turn) + " / " + str(end_turn) 

# Private Methods

## Is the current turn the end turn. 
func is_end_life() -> bool:
	return rel_curr_turn == rel_end_turn

## Increments both curr_turn and rel_curr_turn.
func _increm_turn() -> void:
	curr_turn +=1
	rel_curr_turn +=1

# Constructor Methods

## Used by Constructor to set the apply turns and rel_apply_turns
func _set_apply_turns() -> void:
	rel_apply_turns = []
	apply_turns = []
	for i in range(rel_first_apply, rel_end_turn+1, mod.applied_every): #TODO check whether +1 is valid
		rel_apply_turns.append(i)
		apply_turns.append(i+diff)
