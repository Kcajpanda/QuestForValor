##
extends Entity

class_name StatChanger

## PropOperation used to change the stat.
var prop_operation:PropOperation
## Trigger to execute apply. Trigger for when to act.
var act_trigger:Trigger
## Trigger to execute _death and emit signal for own death.
var death_condition:DeathCondition

#TODO make a more consistent way to control death, include the signal and age, etc.


## 
func _init(name:String, id:int, prop_name:StringName, operation:StringName, val, mutate_or_apply:bool, act_condition:Condition, death_condition:DeathCondition, descr:String=""):
	self.prop_operation = PropOperation.new(prop_name, operation, val, mutate_or_apply)
	act_trigger = Trigger.new(act_condition, operate)
	self.death_trigger = death_condition
	
	super(name, id, self._descr_maker(descr))

## Returns .operate() of .prop_operation.
func operate(prop_val):
	return prop_operation.operate(prop_val)

# Constructor Methods

## Used by constructor to write the explanation part of the descr.
func _descr_maker(descr:String="") -> String:
	return descr + prop_operation.str_operation + str(prop_operation.val) + " to " + prop_operation.prop_name
