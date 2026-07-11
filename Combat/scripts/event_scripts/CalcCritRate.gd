## Event for the calculation of crit_rate(). Takes in and stores the values of weap_crit:int, char_skl:int, and skl_divisor:int. When calc() is called, it computes the val of crit_rate. Critical Rate = Weapon Critical + Skill / 2 + Other Bonus.
extends Event

class_name CalcCritRate

## weap.crit.val
var weap_crit:AlteredVal
## char.skl.val
var char_skl:AlteredVal
## skl_divisor = 2
var skl_divisor:AlteredVal
## critical hitrate
var crit_rate:AlteredVal

## Event for the calculation of crit_rate(). Takes in and stores the values of weap_crit:int, char_skl:int, and skl_divisor:int. When calc() is called, it computes the val of crit_rate. Critical Rate = Weapon Critical + Skill / 2 + Other Bonus.
func _init(weap_crit:int, char_skl:int, skl_divisor:int) -> void:
	self.weap_crit = AlteredVal.new(weap_crit)
	self.char_skl = AlteredVal.new(char_skl)
	self.skl_divisor = AlteredVal.new(skl_divisor)

## Critical Rate = Weapon Critical + Skill / 2 + Other Bonus.
func calc() -> void:
	var result = weap_crit.alter_val + ( char_skl.alter_val / skl_divisor.alter_val )
	crit_rate = AlteredVal.new(result)
