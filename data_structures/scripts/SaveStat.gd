extends Stat

## Extends all function of stat but stores a temp val that is intended to be mutated but can be reset to the oringnal val with reset(). it also has a list of modifiers currently modifying that temp val.
class_name SaveStat

## The temp val for a stat, can be mutated and even set to a differnt val but can always be reset to match the stored perm val (which itself can be changed).
var temp:
	get:
		return temp

## Extends all function of stat but stores a temp val that is intended to be mutated but can be reset to the oringnal val with reset(). it also has a list of modifiers currently modifying that temp val.
func _init(name:String="def_save_stat_name", value=null):
	super(name, value)
	temp = value

## Mutates self.temp	
func mut(value) -> void:
	temp += value

## Returns self.temp == self.val	
func is_diff() -> bool:
	return self.temp == self.val

## Sets self.temp directly
func set_temp(tmp) -> void:
	self.temp = tmp

## Returns self.temp to self.val
func reset() -> void:
	temp = val
	
func _str():
	return stat_name + ": " + str(temp) + "/" + str(val)
