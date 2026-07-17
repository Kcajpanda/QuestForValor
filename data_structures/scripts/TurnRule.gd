## A declarative instance that stores complex turn rules in an easy way to interact with. It takes in essential values for determining the rules, saves them, then generates an array of the turn numbers where the action should execute. When .create_active() is run it constructs and returns an ActiveTurnRule.
extends Rule

class_name TurnRule

## First time of application, 0 = immediately
var first_apply:int
## Number of times modifier affects .prop_name when it is called to apply.
var times_applied:int
## How often a Modifier is called to apply.
var applied_every:int
## How long the Modifier obj lives for, separate from the frequency of its application
var duration:int
## List of turn numbers where the action should execute based on start_turn = 0.
var rel_apply_on_turns:Array[int]
## List of turn numbers where the action should execute based on start_turn the in-game turn when the action was init.
var abs_apply_on_turns:Array[int]
## Human readable version of the rule.
var str_freq:String


## A declarative instance that stores complex turn rules in an easy way to interact with. It takes in essential values for determining the rules, saves them, then generates an array of the turn numbers where the action should execute. When .create_active() is run it constructs and returns an ActiveTurnRule.
func _init(first_apply:int, times_applied:int, applied_every:int, duration:int) -> void:
	self.first_apply = first_apply
	self.times_applied = times_applied
	self.applied_every = applied_every
	self.duration = duration
	self._gen_rel_apply_turns()
	self._det_freq()

## Starts the application of the rule. Turns instance from a state container into something you can get real checks from to determine when the rule ends.
func create_active(start_turn:int) -> ActiveTurnRule:
	return ActiveTurnRule.new(start_turn, duration, rel_apply_on_turns)


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
