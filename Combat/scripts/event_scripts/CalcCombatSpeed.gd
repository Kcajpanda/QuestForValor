## Event for Combat Speed Calculation, has properties .spd, .strn, .weapon_wght. AS = spd - (str - Weapon_weight)
extends Event

class_name CalcCombatSpeed

## char.spd.val.
var spd:int
## char.lck.val.
var strn:int
## weap.wght.val.
var weapon_wght:float

## Event for Combat Speed calculation, has properties .spd, .strn, .weapon_wght. AS = spd - (str - Weapon_weight).
func _init(spd:int, strn:int, weapon_wght:float) -> void:
	self.spd = spd
	self.strn = strn
	self.weapon_wght = weapon_wght
