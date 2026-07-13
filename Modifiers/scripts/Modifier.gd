##
extends StatChanger

class_name Modifier

## Stores the creation param for a modifier of a given name key=modifier_name, to be replaced by Resource later
const MODIFIERS = { # prop_name:StringName, operation:StringName, val=null, act_condition:Condition, death_condition:DeathCondition, descr:String=""
	"Str-boost-I" : ["strn", "add", 2, Condition.new(), Condition.new(), "A small Strength boost,"] # fix to ahve actual conditions or make contructor make them.
}

##
func _init(name:StringName, id) -> void:
	var params:Array = MODIFIERS.get(name) #TODO change to resource file interpretation.
	super(name, id, params[0], params[1], params[2], false, params[3], params[4], params[5])

# _time_to_apply whihc connect to the signal passed as an arg at init, calls apply on the event emited fromk the signal and uses the Prop operaiton on it, modmanager just manages stats and duratiosn of mods.