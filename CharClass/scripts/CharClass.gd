##
extends Resource

class_name CharClass

## Id for class types
const CLASS_IDS = {
	0: "base",
	1: "solider",
	2: "brigand",
}

## Dictionary showing which Growth List to use.
const CLASS_GROWTH_RATES = {
	0: [0,0,0,0,0,0]
}

##
const WEAPON_EFF = {
	0: 1.2
}

## Name of the CharClass
var char_class_name: String
## Id for quick tracking of the CharClass
var id: int
## Can this class weild magic items
var is_magic: bool:
	get:
		return is_magic
## List showign the likelyhood of a given stat to go up when a level up occurs.
var stat_growth_rate: Array[int]
##
#var abilities: Arrary[]

## Outlines Characteristics a character of this class would have
func _init(char_class_name:String, id:int, is_magic:bool, stat_growth_rate:Array[int]) -> void:
	self.char_class_name = char_class_name
	self.id = id
	self.is_magic = is_magic
	self.stat_growth_rate = stat_growth_rate

##
func get_weap_eff(weap_id:int) -> float:
	return WEAPON_EFF.get(weap_id)
