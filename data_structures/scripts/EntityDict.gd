## A Dictionary of every ModTracker, which contains a Modifier, affecting the given stat this list was made for.
extends Resource

class_name EntityDict

## Name of prop it affects, used by ModManager
var prop_name: StringName
## list of Dictionary of modifiers sorted by id (allows for duplicates of modifier with easy distiction between them regardless of the removal of other entries.)
var dict: Dictionary[int, Object]
## Based on turn(), mods that are currently being applied.
var curr_mods:Array[Object]
## start id number
var start_id: int
## id of next entry to be added.
var curr_id: int

## List of Entities designed for easy apply() of mods and deletion when they age or are signaled to remove. 
func _init(prop_name:StringName, mods:Dictionary[int, Object]={}, start_id:int=0, end_signal_name:StringName="end_duration") -> void:
	self.prop_name = prop_name
	self.mods = mods
	curr_mods = []
	start_id = 0
	curr_id = start_id
	self.connect(end_signal_name, _end)

## Increases id by 1.
func _increment_id() -> void:
	curr_id += 1

## Creates an Entity of given name param name.
func make(name:String) -> void:
	dict[curr_id] = 
	self._increment_id()
	
## Removes mod at key param key.
func remove(key:int) -> void:
	mods.erase(key)
	
## Conected method to remove mod of given id whne it signals its death
func _end(id:int, curr_turn:int):
	print(mods.get(id).en_name + " finished on turn " + str(curr_turn) + ".")
	mods.erase(id)
	print("Deletion cofirmed.")

## Returns mod at key param id.
func get_mod(id:int=0) -> Modifier:
	return mods.get(id).mod
	
## Returns ModTracker at key param id.
func get_mod_trck(id:int=0) -> ModTracker:
	return mods.get(id)

## Returns all mods in list, not Modtrackers.
func get_mods() -> Array[Modifier]:
	var out:Array[Modifier] = []
	for key in mods:
		out.append(mods[key].mod)
	return out

## Finds first instance mod of param name and returns it' ModTracker's id.
func find(name:String) -> Array[int]:
	var keys:Array[int] = []
	for key in mods:
		if mods[key].en_name == name:
			keys.append(key)
	return keys

## Runs turn on the given Modtracker at key param id and returns it out.
func run_turn(id:int=0):
	return mods.get(id).turn()

## Runs turn on every Modtracker in .mods and for every !null val, stores its returns out (a mod or null) in an Array.
func run_turns() -> void:
	var out = []
	var output
	for key in mods:
		output = self.run_turn(key)
		if output != null:
			out.append(output)
	curr_mods = out

## Adds mods from Effect to self.mods
func effect(effects:Array[String], curr_turn:int) -> void:
	for name in effects:
		self.make(name, curr_turn)

func _str():
	return str(mods)
