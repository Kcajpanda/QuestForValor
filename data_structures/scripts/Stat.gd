## Stores a val, its name, and a method for updating the val.
extends Resource

class_name Stat

## Name Associated with the Stat instance.
var stat_name : String:
	get:
		return stat_name
## Value stored with the Stat instance.
var val:
	get:
		return val

## Stores a val, its name, and a method for updating the val.
func _init(stat_name:String="def_stat_name", val=null):
	self.stat_name = stat_name
	self.val = val

## Updates self.val	
func update(value) -> void:
	self.val += value
	
func _str():
	return stat_name + ": " + str(val)
