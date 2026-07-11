## Stores the provided val as the _org_val and set alter_val to org_val, Its intended for people to alter alter_val and can check if the val was ever alterd through .was_alterd(). Useful for Events wher vals are altered.  
extends Resource

class_name AlteredVal

## Orignal value stores at _init(). Intended to be private and never changed.
var org_val
## Starts the same as org_val, but meant to be chnaged if needed.
var alter_val
## PorpOperations in the form of OperatedVals that affected alter_val.
var alterations:Array[OperatedVal] #TODO instead of storing modifiers which includes the rule, just what affect occured. is it bad altered_val performs the operation? Dependent on ModManger trackign signals, not modifiers.

## Stores the provided val as the _org_val and set alter_val to _org_val, Its intended for people to alter alter_val and can check if the val was ever alterd through .was_alterd(). Useful for Events wher vals are altered.  
func _init(val) -> void:
	org_val = val
	alter_val = org_val

## Function used for altering alter_val, alters the val and stores the chnages made .alterations.
func alter(operation:PropOperation) -> void:
	var old_alter_val = alter_val
	alter_val = operation.apply(alter_val)
	alterations.append(OperatedVal.new(old_alter_val, operation, alter_val))

## Returns a Str of all the chnages made to alter_val if any.
func out_changes() -> String:
	var out := ""
	for oper_val in alterations:
		out += str(oper_val)
	return out

## Returns whether org_val and alter_val are different.
func was_altered() -> bool:
	return org_val != alter_val
