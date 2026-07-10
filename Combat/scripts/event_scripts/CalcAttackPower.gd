## Event for calculation of attack_power(). Takes in and stores the value for char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int. Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus.
extends Event

class_name CalcAttackPower

## char1.strn.val
var char1_strn:int
## weap1.wght.val
var weap1_wght:int
## tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) )[1]
var tri_bonuses_dmg:int
## char2.get_weap_eff(weap1.id)
var char2_weap_eff:int

## Event for calculation of attack_power(). Takes in and stores the value for char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int. Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus.
func _init(char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int) -> void:
	self.char1_strn = char1_strn
	self.weap1_wght = weap1_wght
	self.tri_bonuses_dmg = tri_bonuses_dmg
	self.char2_weap_eff = char2_weap_eff
