## Event for tri-bonus calculation. takes in the chars .char_rnk with a given weapon, their tri_bonus, and their tri_adv.
extends Event

class_name CalcTriBonus

## Char rank with given weapon.
var char_rnk:int
## What type of advantage the char is at in combat: -1, 0, 1.
var tri_bonus:int
## Bonus to char stats [acc, dmg] based on their weap_rnk and tri_bonus.
var tri_adv:Array[int]

## Event for tri-bonus calculation. takes in the chars .char_rnk with a given weapon, their tri_bonus, and their tri_adv.
func _init(char_rnk:int, tri_bonus:int) -> void:
	self.char_rnk = char_rnk
	self.tri_bonus = tri_bonus

## Determines tri_adv based on .tri_bonus and .char_rnk.
func get_tri_adv(weap:Weapon) -> void:
	if tri_bonus == 1:
		tri_adv = weap.tri_advantages(true, char_rnk)
	elif tri_bonus == -1:
		tri_adv = weap.tri_advantages(false, char_rnk)
	else:
		tri_adv = [0,0]
