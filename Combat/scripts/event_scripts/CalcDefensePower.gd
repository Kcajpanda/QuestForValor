## Event for defense_power() calculation, takes in and stores tile_defn:int, which_stat:bool, char_defn:int, and char_res:int. Defense Power = Terrain Bonus + Defense + Support Bonus.
extends Event

class_name CalcDefensePower

## tile.defn.val
var tile_defn:int
## Input param which_stat
var which_stat:bool
## char.defn.val
var char_defn:int
## char.res.val
var char_res:int

## Event for defense_power() calculation, takes in and stores tile_defn:int, which_stat:bool, char_defn:int, and char_res:int. Defense Power = Terrain Bonus + Defense + Support Bonus.
func _init(tile_defn:int, which_stat:bool, char_defn:int, char_res:int) -> void:
	self.tile_defn = tile_defn
	self.which_stat = which_stat
	self.char_defn = char_defn
	self.char_res = char_res
