## Stores a base val, an operaiton to be preformed on that val, and what the val would be after the operation, they don't contain refrences to the actual chnaged or unchanged vals, they only share magnitudes for the pourpose of tracking and UI usage.
extends Resource

class_name OperatedVal

## value before operation.apply(), the input param.
var base
## the PropOperation acting on the val.
var operation:PropOperation
## value returned by operation.apply().
var post

## Stores a base val, an operaiton to be preformed on that val, and what the val would be after the operation, they don't contain refrences to the actual chnaged or unchanged vals, they only share magnitudes for the pourpose of tracking and UI usage.
func _init(base, operaiton:PropOperation, post) -> void:
	self.base = base
	self.operation = operation
	self.post = post

## Returns "{base} {str_operation} => {post}" 
func _str():
	return str(base) + " " + self.operation.str_operation + " => " + str(post)
