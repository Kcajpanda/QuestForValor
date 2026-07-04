## Data structure to store a named list of Stat or SaveStat objs for easy printing.
extends Resource

class_name StatLs

## Name associated with the StatLs.
var list_name : String
## var that stores the Stats sorted by their name as the key
var ls : Dictionary[String, Stat]

## Data structure to store a named list of Stat or SaveStat objs for easy printing.
func _init(list_name:String = "def_stat_ls_name", ls=[]):
	self.list_name = list_name
	self.ls = ls

## Returns Stat instance with .stat_name of param stat_name
func get_stat(stat_name:String) -> Stat:
	return ls.get(stat_name)

## Applys mod of the stat with given stat name and mod of given index.
func apply(stat_name:String, mod_index:int) -> void:
	self.ls.get(stat_name).apply(mod_index)

## Ages mod of the stat with given stat name, mod of given index, and ages by the given age.
func age(stat_name:String, mod_index:int, age:int=1) -> void:
	self.ls.get(stat_name).age(mod_index,age)

func _str():
	var out = "["
	for item in ls:
		out += str(item) + ","
	return out[-2] + "]"
