## A Named boost that can apply to a stat, designed to be permenant or rarely removed.
extends Entity

class_name Attribute

## val to be applied to a stat
var val

## Same param as Entity but includes the val associated with the Attribute
func _init(name:String, id:int, val, descr:String="") -> void:
	super(name, id, descr)
	self.val = val

## Abstraction for getting self.boost
func apply():
	return val
