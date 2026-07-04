extends Stat

## Extends all function of stat but stores a temp val that is intended to be mutated but can be reset to the oringnal val with reset(). it also has a list of modifiers currently modifying that temp val.
class_name SaveStat

## The temp val for a stat, can be mutated and even set to a differnt val but can always be reset to match the stored perm val (which itself can be changed).
var temp:
	get:
		return temp
## List of modifers currently affecting the temp stat. Starts as empty
var mods: Array[Modifier]:
	get:
		return mods

## Extends all function of stat but stores a temp val that is intended to be mutated but can be reset to the oringnal val with reset(). it also has a list of modifiers currently modifying that temp val.
func _init(name:String="def_save_stat_name", value=null):
	super(name, value)
	temp = value
	self.mods = []

## Mutates self.temp	
func mut(value) -> void:
	temp += value

## Returns self.temp == self.val	
func is_diff() -> bool:
	return self.temp == self.val

## Sets self.temp directly
func set_temp(tmp) -> void:
	self.temp = tmp

## Appends given modifier to self.mods
func add_mod(mod:Modifier) -> void:
	mods.append(mod)

## Applies modifier at self.mods[index], and ages the modifier by age.
func apply_mod(index:int=0, age:int=1) -> void:
	var modifier: Modifier = self.mods[index]
	mut(modifier.apply())
	self.age_mod(index, age)

## Ages modifier by age and checks if its time to remove it, if so it reverst the change to self.temp and removes it from self.mods.
func age_mod(index:int=0,age:int=1) -> void:
	var modifier: Modifier = mods[index]
	var time_to_remove: bool = modifier.age(age)
	if time_to_remove:
		mut(modifier.reverse())
		mods.remove_at(index)

## Loops over mods and calls apply() on each
func apply_mods(age:int=1) -> void:
	for n in len(mods):
		mut(self.mods[n].apply())
		self.age_mod(n, age)

## Loops over mods and call age() on each, aging each by param age.
#func age_mods(age:int=1) -> void:
	#for mod in mods:
		#mut(mod.age(age))

## Returns self.temp to self.val
func reset() -> void:
	temp = val
	
func _str():
	var out = stat_name + ": " + str(temp) + "/" + str(val) + "["
	for mod in mods:
		out += str(mod) + ", "
	return out[-2] + "]"
