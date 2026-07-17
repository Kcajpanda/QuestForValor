## Simple Wrapper for a value that lest you store the val, and a string form of the val.
extends Resource

class_name StringStat

## raw val representing the stat
var val
## how raw should be seen as a String
var str_val: String

## Simple Wrapper for a value that lest you store the val, and a string form of the val.
func _init(raw, raw_str:String) -> void:
	self.val = val
	self.str_val = str_val

func _str():
	return str_val
	
