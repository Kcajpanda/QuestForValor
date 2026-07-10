## Event for calculation of avoid(). takes in combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus.
extends Event

class_name CalcAvoid

## Char combat_speed().
var combat_spd:int
## Constant multiplied by combat_spd.
var combat_spd_mult:int
## char.lck.val.
var char_lck:int
## tile.dge.val.
var tile_dge:int

## Event for calculation of avoid(). takes in combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus.
func _init(combat_spd:int, combat_spd_mult:int, char_lck:int, tile_dge:int) -> void:
	self.combat_spd = combat_spd
	self.combat_spd_mult = combat_spd_mult
	self.char_lck = char_lck
	self.tile_dge = tile_dge
