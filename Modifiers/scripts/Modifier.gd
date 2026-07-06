## A Modifier, is owned by a Stat (or a sublcass of it) to modifier and Stat, has a val to apply to the Stat and age which have age() to decrease it age over time.
extends AgeEntity

class_name Modifier

## Stores the creation param for a modifier of a given name key=modifier_name
const MODIFIERS = { # prop_name:StringName, uses:int=0, val=null
	"default": ["none", 1, 0],
	"posion-I_2_4" : ["hp", 2, 4],
	"posion-II_4_4" : ["hp", 4, 4],
	"posion-III_6_4" : ["hp", 6, 4],
}

## the target obj of the modifier
var target:Object
### the type of obj the mod can be applied to 
#var class_type:Object
## Name of property of target to be modified
var prop_name:StringName
## Value associated with modifier, used by calling apply on the Modifier(or its subclass) instance to return that self.val, which si sued by the Stat (or its subclass) that uses it.
var val

## A Modifier, a subclass of AgeEntity, with a stored target, target_type, and prop_name that it modifies. The Modifier only exists when it has a target, Effects are used to create Modifiers as needed to avoid targetless mods.
func _init(name:String, id:int, target:Object):
	var params: Array = MODIFIERS.get(name)
	super(name, id, params[1])
	self.prop_name = params[0]
	self.val = params[2]
	
	if self._validate(target):
		self.target = target
		
		
		
# create event class, make it so whnever a weapon is unequipped or equippe dit signals, triggers the event and th event is owned by the ConMod
	
## checks whether target has the desired property.
func _validate(target:Object) -> bool:
	return prop_name in target

## Applies stored val to the self.target.prop_name
func apply(age:int=1) -> bool:
	target.prop_name += val
	return self.age(age)

## applies the -(val) to the self.target.prop_name
func reverse(obj) -> void:
	target.prop_name += -val
	
## returns "en_name: id| {id}, uses={self.uses}, target={target}, class_type: {class_type), prop_name: {prop_name}, val={self.val}, descr"
func _str():
	return super._str_helper() + "target=" + str(typeof(target)) + "prop_name: " + str(prop_name) +  "val=" + str(val) + ", " + descr
