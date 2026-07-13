## Data Structure containing a property and operation function to use on the property, and a val to use with that function. .apply() return the difference between the prop_value given and what it would be after the operation.
extends ValOperation

class_name PropOperation

## Name of property to be affected.
var prop_name:StringName

## Takes in the name of the property to operate on, the name of the operation func, and the val to use with the operation func. Optional for basic arithmetic operations str_operations can be included to give the function and more human readable form like +, -, etc. If not given str_operation sets to operation_name.
func _init(prop_name:StringName, operation_name:StringName, val, mutate_or_apply:bool, str_operation:String="") -> void:
	self.prop_name = prop_name
	super(operation_name, val, mutate_or_apply, str_operation)
