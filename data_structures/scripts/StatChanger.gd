##
extends Entity

class_name StatChanger

## PropOperation used to change the stat.
var prop_operation:PropOperation
## Rules to determine when the PropOperation should .apply(). 
var rules:TurnRule

## 
func _init(name:String, id:int, prop_name:StringName, operation:StringName, val, first_apply:int, times_applied:int, applied_every:int, duration:int, descr:String=""):
	self.prop_operation = PropOperation.new(prop_name, operation, val)
	self.rules = TurnRule.new(first_apply, times_applied, applied_every, duration)
	
	super(name, id, self._descr_maker(descr))

## Returns .apply() of .prop_operation.
func apply(prop_val):
	return prop_operation.apply(prop_val)

## Returns rules.is_apply_turn
func is_turn_to_apply(start_turn:int, curr_tunr:int) -> bool:
	return rules.is_apply_turn(start_turn, curr_tunr)

# Constructor Methods

## Used by constructor to write the explanation part of the descr.
func _descr_maker(descr:String="") -> String:
	return descr + prop_operation.str_operation + str(prop_operation.val) + " to " + prop_operation.prop_name + rules.str_freq
