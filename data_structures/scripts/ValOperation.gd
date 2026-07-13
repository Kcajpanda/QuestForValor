## Data Structure containing a operation function to use on the any inputed val, and a val to use with that function. Meant to alter Non-property vals like func-outputs.
extends Resource

class_name ValOperation

## Func to modify the property.
var operation:Callable
## Saved StringName of the operation function.
var operation_name:StringName
## Whether to use mutate:true or apply:false when operate is called.
var mutate_or_apply:bool
## The human readable form of the operation func.
var str_operation:String
## Val to be used to affect the property.
var val:Variant

## Takes in the name of the operation func, and the val to use with the operation func. Optional for basic arithmetic operations str_operations can be included to give the function and more human readbale form like +, -, etc. If not given str_operation sets to operation_name.
func _init(operation_name:StringName, val, mutate_or_apply:bool, str_operation:String="") -> void:
	operation = Callable(self, operation_name)
	self.operation_name = operation_name
	if str_operation == "":
		self.str_operation = operation_name
	else:
		self.str_operation = str_operation
	self.val = val
	self.mutate_or_apply = mutate_or_apply

## Depending on what .mutate_or_apply is specified as it operates, meanign it calls .apply() or .mutate().
func operate(value):
	if mutate_or_apply:
		return self.mutate(value)
	else:
		return self.apply(value)

## Returns the difference bewteen what the value is and what it would after .operation.call()
func apply(value):
	return value - self.operation.call(value, self.val)

## Instead of returning the difference like apply(), it mutates the value directly. Designed for Effects.
func mutate(value):
	value = self.operation.call(value, self.val)
