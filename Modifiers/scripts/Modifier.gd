## A Modifier, is owned by a Stat (or a sublcass of it) to modifier and Stat, has a val to apply to the stored .prop_name by the operand or func mod_func, with a given number of uses managed by AgeEntity Logic. it does not modify stats itself, but instead indicated how they should be modified.
extends Entity

class_name Modifier

## Stores the creation param for a modifier of a given name key=modifier_name
const MODIFIERS = { # prop_name:StringName, mod_func:String, val=null, times_applied:int, applied_every:int, duration:int, desc:=""
	"default": ["none", 1, 0],
	"posion-I_2_4" : ["hp", "-", 2, 0, 1, 1, 4, "A weak Posion affect,"],
	"posion-II_4_4" : ["hp", "-", 4, 0, 1, 1, 4, "A potent Poision affect,"],
	"posion-III_6_4" : ["hp", "-", 6, 0, 1, 2, 4, "A catastrophic Poision Affect,"],
	"Str-boost-I" : ["strn", "+", 2, 0, 1, 4, 4, "A small Strength boost,"]
}

## Name of property of target to be modified
var prop_name:StringName
## Strign representing what obj.prop_name mod_func val, where mod_func is a mathmatical operand or (in the future) a more complex func  
var mod_func:String
## Value associated with modifier, used by calling apply on the Modifier(or its subclass) instance to return that self.val, which si sued by the Stat (or its subclass) that uses it.
var val
## First time of application, 0 = immedietly
var first_apply:int
## Number of times modifier affects .prop_name when it is called to apply.
var times_applied:int
## How often a Modifier is called to apply.
var applied_every:int
## How long the Modifier obj lives for, seperate from the frequncy of its application
var duration:int
## Signal indicating its tiem for the mod to be deleted
signal end_mod

## A Modifier, a subclass of AgeEntity, stores the name of the property it modifies, what operand or function it uses to modify it, what val it modifies by, and all the properties of its parent. Used by other obj and ModManager to alter the stats by a given amount.
func _init(name:String, id:int):
	var params:Array = MODIFIERS.get(name)
	
	prop_name = params[0]
	mod_func = params[1]
	val = params[2]
	first_apply = params[3]
	times_applied = params[4]
	applied_every = params[5]
	duration = params[6]
	
	super(name, id, self._descr_maker(params[7]))

## Returns relevant info for immediet application
func apply() -> Array:
	return [prop_name, mod_func, val]

# Private Methods

## Determines the wording for when an dhow often the modifier is to be applied.
func _det_freq() -> String:
	var out:= ""
	if first_apply != 0:
		out += "begining in " + str(first_apply) + " turn "
	if times_applied == duration:
		return out + " for " + str(duration) + " turns."
	else:
		return out + " applied " + str(times_applied) + " every " + str(applied_every) + " turns for " + str(duration) + "turns."

## Used by constructor to write the explanation part of the descr.
func _descr_maker(descr:String="") -> String:
	return descr + ", " + mod_func + str(val) + " to " + prop_name + self._det_freq()

## Returns "en_name: id| {id}, uses={self.uses}, prop_name: {prop_name}, mod_func: {mod_func}, val={self.val}, descr"
func _str():
	return super._str_helper() + "prop_name: " + str(prop_name) + "mod_func: " + mod_func + "val=" + str(val) + ", " + descr
