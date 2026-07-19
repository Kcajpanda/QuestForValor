## Parent Class of all items in game, utilities Entity for naming, id, and a description (default=""). Contains a NumUses obj for tracking uses.
extends NumUsesEntity

class_name Item


## Parent Class of all items in game, utilities Entity for naming, id, and a description (default=""). Contains a NumUses obj for tracking uses.
func _init(item_name:String, id:int, uses:int, descr:String=""):
	super(item_name, id, uses, descr)

## Parent func to use an item, implementation differs among children
func use(dec_by_val:int) -> void:
	dec_uses(dec_by_val)
		
func _str():
	return en_name + ": id | " + str(id) + ", " + str(uses)
