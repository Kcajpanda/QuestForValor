## Contains modlists, a Dictionary with key:prop_name, val:ModList for every prop_name in the input Array[StringName] prop_names

#TODO modifer has two subcalsses, supplementalMod, directod, each contain an Effect what owns a functiona nd a val, modifiers dictate rules and depndign on sublcas how its applied, Modtracker and other higher classes may just need to be bale to tell the type of Mod subclasss, or have sublasses of their own

"""
One other thought based on our previous conversations: you mentioned that your modifiers aren't limited to simple + or - operations and can have arbitrary behavior. I think that's a great direction, and it fits nicely here. Rather than having each modifier return a value to be applied, I'd lean toward each modifier implementing behavior through well-defined hooks. For example, a stat modifier might implement something like modify_stat(current_value) or participate in a calculation pipeline, while an effect implements execute(target) or on_turn_start(target). That lets each modifier encapsulate its own logic without forcing the ModifierManager to understand every possible kind of operation. The manager's job becomes orchestrating when things happen; the character's job is owning state; and each modifier or effect defines how it changes the outcome. I think that separation will keep the system flexible as Quest for Valor grows.
"""

extends Resource

class_name ModManager

## The Full dictionary catalog of mods pertaining to a list of properties.
var modlists: Dictionary[StringName, ModList]
## List of all property names, not used, just for recording purposes.
var prop_names: Array[StringName]

## Stores the list of names, and makes a ModList inside modlists with the key being the individual prop_names.
func _init(prop_names:Array[StringName]) -> void:
	self.prop_names = prop_names
	for name in self.prop_names:
		modlists[name] = ModList.new(name)

## Returns ModList corresponding to key param prop_name.
func modlist_for(prop_name:StringName) -> ModList:
	return modlists.get(prop_name)

## Returns .curr_mods for the given modlist in .modlists
func get_curr_mods_for(prop_name:StringName) -> Array[Modifier]:
	return modlists.get(prop_name).curr_mods
	
## Runs .run_turns for the given modlist in .modlists.
func run_turns_for(prop_name:StringName) -> void:
	modlists.get(prop_name).run_turns() 
	
##
func apply_mod(mod:Modifier, prop_val):
	var temp = prop_val
	var post = mod.ref_func.call(prop_val)
	print(str(temp) + " => " + str(post))
	return post
	
## Runs each .ref_func() from the given curr_mods, sequntially changing total, simulating edits to the stat prop_val without changing it (base don current guidlines).
func apply_for(prop_name:StringName, prop_val):
	self.run_turns_for(prop_name)
	var curr_mods:Array[Modifier] = self.get_curr_mods_for(prop_name)
	
	var total = prop_val
	for mod in curr_mods:
		total = self.apply_mod(mod, total)
	return total
