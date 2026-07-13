##
extends Entity

class_name StatChanger

## PropOperation used to change the stat.
var prop_operation:PropOperation
## Rules to determine when the PropOperation should .apply(). 
var rules:TurnRule
##
var act_trigger:Trigger
##
signal death_signal

## 
func _init(name:String, id:int, prop_name:StringName, operation:StringName, val, act_signal:Signal, descr:String=""):
	self.prop_operation = PropOperation.new(prop_name, operation, val)
	self.act_trigger = Trigger.new(act_signal, apply)
	
	super(name, id, self._descr_maker(descr))

## Returns .apply() of .prop_operation.
func apply(prop_val):
	return prop_operation.apply(prop_val)

# Constructor Methods

## Used by constructor to write the explanation part of the descr.
func _descr_maker(descr:String="") -> String:
	return descr + prop_operation.str_operation + str(prop_operation.val) + " to " + prop_operation.prop_name + rules.str_freq
