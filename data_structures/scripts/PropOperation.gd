## Data Structure containing a property and operation function to use on the property, and a val to use with that function. .apply() return the differnce bewteen the prop_value given and what it would be after the operation.
extends Resource

class_name PropOperation

## Name of property to be affected.
var prop_name:StringName
## Func to modify the property.
var operation:Callable
## Saved StringName of the operation function.
var operation_name:StringName
## The human readable form of the operation func.
var str_operation:String
## Val to be used to affect the property.
var val:Variant

## Takes in the name of the property to operate on, the name of the operation func, and the val to use with the operation func. Optional for basic arithmatic operations str_operations can be included to give the function and more human readbale form like +, -, etc. If not given str_operation sets to operation_name.
func _init(prop_name:StringName, operation_name:StringName, val, str_operation:String="") -> void:
	self.prop_name = prop_name
	operation = Callable(self, operation_name)
	self.operation_name = operation_name
	if str_operation == "":
		self.str_operation = operation_name
	else:
		self.str_operation = str_operation
	self.val = val

## Returns the difference bewteen what the stat is and what it would after .operation.call() so the char know how much to mutate or supplement the stat by.
func apply(prop_val):
	return prop_val - self.operation.call(prop_val, self.val)
