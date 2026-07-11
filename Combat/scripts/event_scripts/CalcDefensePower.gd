## Event for defense_power() calculation, takes in and stores tile_defn:int, which_stat:bool, char_defn:int, and char_res:int. when .calc() is called it computes defense_power. Defense Power = Terrain Bonus + Defense + Support Bonus.
extends CombatCalcEvent

class_name CalcDefensePower

## tile.defn.val
var tile_defn:AlteredVal
## Input param which_stat
var which_stat:AlteredVal
## char.defn.val
var char_defn:AlteredVal
## char.res.val
var char_res:AlteredVal
## defense power
var defense_power:AlteredVal

## Event for defense_power() calculation, takes in and stores tile_defn:int, which_stat:bool, char_defn:int, and char_res:int. when .calc() is called it computes defense_power. Defense Power = Terrain Bonus + Defense + Support Bonus.
func _init(tile_defn:int, which_stat:bool, char_defn:int, char_res:int) -> void:
	self.tile_defn = AlteredVal.new(tile_defn)
	self.which_stat = AlteredVal.new(which_stat)
	self.char_defn = AlteredVal.new(char_defn)
	self.char_res = AlteredVal.new(char_res)

## Defense Power = Terrain Bonus + Defense + Support Bonus.
func calc() -> void:
	var dp:int = self.tile_defn.alter_val
	if self.which_stat: #defn
		dp += self.char_defn.alter_val
	else: # res
		dp += self.char_res.alter_val
	defense_power = AlteredVal.new(dp)
