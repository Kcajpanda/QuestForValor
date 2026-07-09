## Parent Class of all items in game, utilizies Entity for naming and id  a description (default="").
extends AgeEntity

class_name Item



## Parent Class of all items in game, contains item_name, its unique id for that type of item, durability for item aging, a bool can_age for wether and item can have its durability change, and a description (default="").
func _init(item_name:String, id:int, uses:int, class_type:Variant, prop_name:StringName, descr:String=""):
	super(item_name, id, uses, descr)

## Parent fucn to use an item, implementation differs among children
func use(value:int=1):
	if ageable:
		self.age(value)
		
func _str():
	var out:= en_name + ": id | " + str(id) + ", uses | "
	if ageable:
		out += str(uses) + ", "
	else:
		out += "--, "
	return out + descr
