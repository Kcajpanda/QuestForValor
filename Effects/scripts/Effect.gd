##
extends StatChanger

class_name Effect

## Stores the creation param for a modifier of a given name key=modifier_name, to be replaced by Resource later
const EFFECTS = { # prop_name:StringName, operation:StringName, val=null, first_apply:int, times_applied:int, applied_every:int, duration:int, desc:=""
	"default": ["none", 1, 0],
	"posion-I_2_4" : ["hp", "subtract", 2, 0, 1, 1, 4, "A weak Posion affect,"],
	"posion-II_4_4" : ["hp", "subtract", 4, 0, 1, 1, 4, "A potent Poision affect,"],
	"posion-III_6_4" : ["hp", "subtract", 6, 0, 1, 2, 4, "A catastrophic Poision Affect,"],
}

##
func _init(name:StringName, id) -> void:
	var params:Array = EFFECTS.get(name) #TODO change to resource file interpretation.
	super(name, id, params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7])
