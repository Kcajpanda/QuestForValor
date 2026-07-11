## Event for calculation of attack_power(). Takes in and stores the value for char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int. When calc() is called it computes attack_power. Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus.
extends Event

class_name CalcAttackPower

## char1.strn.val
var char1_strn:AlteredVal
## weap1.wght.val
var weap1_wght:AlteredVal
## tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) )[1]
var tri_bonuses_dmg:AlteredVal
## char2.get_weap_eff(weap1.id)
var char2_weap_eff:AlteredVal
## attack power.
var attack_power:AlteredVal

## Event for calculation of attack_power(). Takes in and stores the value for char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int. When calc() is called it computes attack_power. Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus.
func _init(char1_strn:int, weap1_wght:int, tri_bonuses_dmg:int, char2_weap_eff:int) -> void:
	self.char1_strn = AlteredVal.new(char1_strn)
	self.weap1_wght = AlteredVal.new(weap1_wght)
	self.tri_bonuses_dmg = AlteredVal.new(tri_bonuses_dmg)
	self.char2_weap_eff = AlteredVal.new(char2_weap_eff)

## Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus.
func calc() -> void:
	var result = char1_strn.alter_val + ( weap1_wght.alter_val + tri_bonuses_dmg.alter_val ) * char2_weap_eff.alter_val
	attack_power = AlteredVal.new(result)
