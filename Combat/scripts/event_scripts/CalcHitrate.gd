## Event for Hitrate calculation. Takes in .weapon_acc, .skl, .skl_multiplier, .lck, lck_divisor. When calc() is called, it computes hitrate. HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
extends Event

class_name CalcHitrate

## Weapon accuracy
var weap_acc:AlteredVal
## Char skill
var skl:AlteredVal
## Constant that multplies skill in the calc
var skl_multplier:AlteredVal
## Char luck
var lck:AlteredVal
## Constant that divides luck in the calc
var lck_divisor:AlteredVal
## hitrate.
var hitrate:AlteredVal

## Event for Hitrate calculation. Takes in .weapon_acc, .skl, .skl_multiplier, .lck, lck_divisor. When calc() is called, it computes hitrate. HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func _init(weap_acc:int, skl:int, skl_multplier:int, lck:int, lck_divisor:int) -> void:
	self.weap_acc = AlteredVal.new(weap_acc)
	self.skl = AlteredVal.new(skl)
	self.skl_multplier = AlteredVal.new(skl_multplier)
	self.lck = AlteredVal.new(lck)
	self.lck_divisor = AlteredVal.new(lck_divisor)

## HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func calc() -> void:
	var result = weap_acc.alter_val + skl.alter_val * skl_multplier.alter_val + float( lck.alter_val / lck_divisor.alter_val )
	hitrate = AlteredVal.new(result)
