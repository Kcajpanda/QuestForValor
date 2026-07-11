## Event for Combat Speed calculation, has properties .spd, .strn, .weapon_wght. When calc() is called, it computes combat_speed. AS = spd - (str - Weapon_weight).
extends Event

class_name CalcCombatSpeed

## char.spd.val.
var spd:AlteredVal
## char.lck.val.
var strn:AlteredVal
## weap.wght.val.
var weapon_wght:AlteredVal
## combat speed.
var combat_speed:AlteredVal

## Event for Combat Speed calculation, has properties .spd, .strn, .weapon_wght. When calc() is called, it computes combat_speed. AS = spd - (str - Weapon_weight).
func _init(spd:int, strn:int, weapon_wght:float) -> void:
	self.spd = AlteredVal.new(spd)
	self.strn = AlteredVal.new(strn)
	self.weapon_wght = AlteredVal.new(weapon_wght)

## AS = spd - (str - Weapon_weight)
func calc() -> void:
	var result = spd.alter_val - (strn.alter_val - weapon_wght.alter_val)
	combat_speed = AlteredVal.new(result)
