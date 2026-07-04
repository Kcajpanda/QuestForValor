extends Modifier

## Works like a modifier but has a condition that must be apssed before it can be applied.
class_name ConMod

## The condition that must be fulfilled in order for the mod to be applied.
var con
## Bool tracking wether trhe condition has been met, is chnaged by a signal and the bool is used to trigger the apply() when mods are later checked.
var is_met: bool
## Signal tracking whether the condiiton has been met, triggers the chnage to is_met, but apply() isn't called untill stats are checked.
signal con_met

## A Modifier, is owned by a Stat (or a sublcass of it) to modifier and Stat, has a val to apply to the Stat and age which have age() to decrease it age over time.
func _init(id:String = "def_con_mod", dur:int=0, val=null, con=null):
	super(id, dur, val)
	self.con = con
	self.connect("con_met", _on_con_met())

## Changes value of self.is_met, represents the condition beign met.
func _on_con_met():
	self.is_met = true

## Checks if condition is met, if so it returns self.val, used by Stat to apply the Modifier.
func apply() -> int:
	if is_met:
		return val
	else:
		return 0
	
func _str():
	return id + ": [dur=" + str(dur) + ", val=" + str(val) + ", condition=" + str(con) + "]"
