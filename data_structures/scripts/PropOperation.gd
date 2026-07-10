## Data Structure containing a property and operation function to use on the property, and a val to use with that function. .apply() return the differnce bewteen the prop_value given and what it would be after the operation.
extends ValOperation

class_name PropOperation

## Name of property to be affected.
var prop_name:StringName

## Takes in the name of the property to operate on, the name of the operation func, and the val to use with the operation func. Optional for basic arithmatic operations str_operations can be included to give the function and more human readbale form like +, -, etc. If not given str_operation sets to operation_name.
func _init(prop_name:StringName, operation_name:StringName, val, str_operation:String="") -> void:
	self.prop_name = prop_name
	super(operation_name, val, str_operation)

## Returns the difference bewteen what the stat is and what it would after .operation.call() so the char know how much to mutate or supplement the stat by.
func apply(prop_val):
	return prop_val - self.operation.call(prop_val, self.val)
