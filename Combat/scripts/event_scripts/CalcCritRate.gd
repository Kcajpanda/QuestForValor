## Event for the calculation of crit_rate(). Takes in and stores the values of weap_crit:int, char_skl:int, and skl_divisor:int. Critical Rate = Weapon Critical + Skill / 2 + Other Bonus.
extends Event

class_name CalcCritRate

## weap.crit.val
var weap_crit:int
## char.skl.val
var char_skl:int
## skl_divisor = 2
var skl_divisor:int

## Event for the calculation of crit_rate(). Takes in and stores the values of weap_crit:int, char_skl:int, and skl_divisor:int. Critical Rate = Weapon Critical + Skill / 2 + Other Bonus.
func _init(weap_crit:int, char_skl:int, skl_divisor:int) -> void:
	self.weap_crit = weap_crit
	self.char_skl = char_skl
	self.skl_divisor = skl_divisor
