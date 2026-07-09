##
extends Resource

class_name StringStat

## raw val represetning the stat
var raw
## how raw should be seen as a String
var raw_str: String

##
func _init(raw, raw_str:String) -> void:
	self.raw = raw
	self.raw_str = raw_str
	
