##
extends Resource

class_name TurnRule

## First time of application, 0 = immedietly
var first_apply:int
## Number of times modifier affects .prop_name when it is called to apply.
var times_applied:int
## How often a Modifier is called to apply.
var applied_every:int
## How long the Modifier obj lives for, seperate from the frequncy of its application
var duration:int
## List of turn numbers where the action should execute based on start_turn = 0.
var rel_apply_on_turns:Array[int]
## List of turn numbers where the action should execute based on start_turn the in-game turn when the action was init.
var abs_apply_on_turns:Array[int]
## Human readbale version of the rule.
var str_freq:String
## Signal indicating its tiem for the mod to be deleted
signal end_duration

## Takes in essential values for determinign the rules, saves them, then generates an array of the turn numbers where the action should execute.
func _init(first_apply:int, times_applied:int, applied_every:int, duration:int) -> void:
	self.first_apply = first_apply
	self.times_applied = times_applied
	self.applied_every = applied_every
	self.duration = duration
	self._gen_rel_apply_turns()
	self._det_freq()

##
func is_duration_finished(start_turn:int, curr_turn:int) -> void:
	if curr_turn == start_turn + duration:
		end_duration.emit(curr_turn)

##
func is_apply_turn(start_turn:int, curr_turn:int) -> bool:
	for rel_apply_turn_num in rel_apply_on_turns:
		if curr_turn == rel_apply_turn_num + start_turn:
			return true
	return false

##
func is_apply_rel_turn(rel_curr_turn:int) -> bool:
	return rel_curr_turn in self.rel_apply_on_turns

## Intended to generate turn numbers when action should execute based on the in-game turn system, not generate at construction of object. 
func gen_abs_apply_turns(start_turn:int) -> void:
	self.start_turn = start_turn
	self.end_turn = start_turn + duration
	abs_apply_on_turns = []
	for turn_num in self.rel_apply_on_turns:
		abs_apply_on_turns.append(turn_num + start_turn)

# Constructor Methods

## Based on a relative start turn of 0, it generates all the turns where the action should execute, saving a relative one (base don start turn 0), and absolute one (based on the actual in game turn numbers) to their appropriate properties.
func _gen_rel_apply_turns() -> void:
	rel_apply_on_turns = []
	for i in range(first_apply, duration+1, applied_every): #TODO check whether +1 is valid
		rel_apply_on_turns.append(i)

## Determines the wording for when and how often the action executes.
func _det_freq() -> void:
	str_freq = ""
	if first_apply != 0:
		str_freq += "begining in " + str(first_apply) + " turn "
	if times_applied == duration:
		str_freq += " for " + str(duration) + " turns."
	else:
		str_freq += " applied " + str(times_applied) + " every " + str(applied_every) + " turns for " + str(duration) + "turns."
