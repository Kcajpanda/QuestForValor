## Parent Class of all items in game, utilizies Entity for naming and id  a description (default="").
extends AgeEntity

class_name Item



## Parent Class of all items in game, contains item_name, its unique id for that type of item, durability for item aging, a bool can_age for wether and item can have its durability change, and a description (default="").
func _init(item_name:String, id:int, dur:int, class_type:Variant, prop_name:StringName, descr:String=""):
	super(item_name, id, dur, descr)

## Decrease the dur by value, if the item can_age, then returns a bool of wether its time for it to be deleted. 
func age(value:int=1) -> bool:
	self.dur -= value
	if self.dur <= 0:
		return true
	else:
		return false
		
## Parent fucn to use an item, implementation differs among children
func use(value:int=1):
	if can_age:
		self.age(value)
		
func _str():
	var out:= en_name + ": id | " + str(id) + ", dur | "
	if can_age:
		out += str(dur) + ", "
	else:
		out += "--, "
	return out + descr
