## A Modifier, is owned by a Stat (or a sublcass of it) to modifier and Stat, has a val to apply to the Stat and age which have age() to decrease it age over time.
extends AgeEntity

class_name Modifier

## Stores the creation param for a modifier of a given name key=modifier_name
const MODIFIERS = {
	"default": [0, 0],
	"posion-I_2_4" : [2,4],
	"posion-II_4_4" : [4,4],
	"posion-III_6_4" : [6,4],
}

### Key used to find the Modifer in MOD_LIST, or its subclass equivalent.
#var id: String:
	#get:
		#return id
##
var class_type:Object
##
var prop_name:StringName
## Value associated with modifier, used by calling apply on the Modifier(or its subclass) instance to return that self.val, which si sued by the Stat (or its subclass) that uses it.
var val

## A Modifier, is owned by a Stat (or a sublcass of it) to modifier and Stat, has a val to apply to the Stat and age which have age() to decrease it age over time.
func _init(name:String, id:int, class_type:Object, prop_name:StringName, uses:int=0, val=null):
	super(name, id, uses)
	self.class_type = class_type
	self.prop_name = prop_name
	self.val = val

## 
func apply(obj) -> void:
	if is_instance_of(obj, class_type):
		class_type.prop_name += val

## 
func reverse(obj) -> void:
	if is_instance_of(obj, class_type):
		class_type.prop_name += -val
	
## returns "en_name: id| {id}, uses={self.uses}, val={self.val}, descr"
func _str():
	return super._str_helper() + " val: " + str(val) + ", " + descr
