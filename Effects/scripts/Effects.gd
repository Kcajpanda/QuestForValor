## Array wrapper, stores the names/id of the mods it grants. Used to tell target to make add these mods.
extends Resource

class_name Effects

## List mod names it grants.
var effects:Array[String]
## 

# make signal based, build ConMod first

## Array wrapper,
func _init(names:Array[String]) -> void:
	#TODO validate them somehow
	effects = names

## Returns effects.
func effect(target:Object) -> void:
	target.mods.effect(target, effects)

func _str():
	var out = "["
	for name in effects:
		out += name + ", "
	return out[-2] + "]"
