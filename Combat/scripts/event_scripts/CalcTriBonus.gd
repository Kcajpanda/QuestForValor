## Event for tri-bonus calculation. takes in the chars .char_rnk with a given weapon, their tri_bonus, and their tri_adv.
extends Event

class_name CalcTriBonus

## Char rank with given weapon.
var char_rnk:AlteredVal
## What type of advantage the char is at in combat: -1, 0, 1.
var tri_bonus:AlteredVal
## Bonus to char stats [acc, dmg] based on their weap_rnk and tri_bonus.
var tri_adv:AlteredVal

## Event for tri-bonus calculation. takes in the chars .char_rnk with a given weapon, their tri_bonus, and their tri_adv.
func _init(char_rnk:int, tri_bonus:int) -> void:
	self.char_rnk = AlteredVal.new(char_rnk)
	self.tri_bonus = AlteredVal.new(tri_bonus)

## Determines tri_adv based on .tri_bonus and .char_rnk.
func get_tri_adv(weap:Weapon) -> void:
	var result:Array[int]
	if tri_bonus.alter_val == 1:
		result = weap.tri_advantages(true, char_rnk.alter_val)
	elif tri_bonus.alter_val == -1:
		result = weap.tri_advantages(false, char_rnk.alter_val)
	else:
		result = [0,0]
	tri_adv = AlteredVal.new(result)
