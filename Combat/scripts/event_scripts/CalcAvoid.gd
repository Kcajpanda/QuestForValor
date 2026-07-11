## Event for calculation of avoid(). takes in combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int. When calc() is called, its computes avoid. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus.
extends Event

class_name CalcAvoid

## Char combat_speed().
var combat_spd:AlteredVal
## Constant multiplied by combat_spd.
var combat_spd_mult:AlteredVal
## char.lck.val.
var char_lck:AlteredVal
## tile.dge.val.
var tile_dge:AlteredVal
## avoid.
var avoid:AlteredVal

## Event for calculation of avoid(). takes in combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int. When calc() is called, its computes avoid. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus.
func _init(combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int) -> void:
	self.combat_spd = AlteredVal.new(combat_spd)
	self.combat_spd_mult = AlteredVal.new(combat_spd_mult)
	self.char_lck = AlteredVal.new(char_lck)
	self.tile_dge = AlteredVal.new(tile_dge)

## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus.
func calc() -> void:
	var result = combat_spd.alter_val * combat_spd_mult.alter_val + char_lck.alter_val + tile_dge.alter_val
	avoid = AlteredVal.new(result)
