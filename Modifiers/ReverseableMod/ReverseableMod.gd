## Just like a modifier but includes a function which can be used to reverse its affects.
extends Modifier

class_name ReverseableMod

const REVERSEABLE_MODS = {
	0: []
}

## Inverse function of mod_func to undo its affects
var reverse:Callable

## Same args as Modifier but includes an optional special_func which is directly set to reverse, if not given, fucntion logic determines reverse.
func _init(name:String, id, special_func:Callable=Callable()) -> void:
	super(name, id)
	
	if special_func == Callable():
		match mod_func:
			MOD_FUNC.ADD:
				reverse = subtract
			MOD_FUNC.SUBTRACT:
				reverse = add
			MOD_FUNC.MULTIPLY:
				reverse = divide
			MOD_FUNC.DIVIDE:
				reverse = multiply
	else:
		reverse = special_func
