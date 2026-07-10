## Event for Hitrate calculation. Takes in .weapon_acc, .skl, .skl_multiplier, .lck, lck_divisor. HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
extends Event

class_name CalcHitrate

## Weapon accuracy
var weap_acc:int
## Char skill
var skl:int
## Constant that multplies skill in the calc
var skl_multplier:int
## Char luck
var lck:int
## Constant that divides luck in the calc
var lck_divisor:int

## Event for Hitrate calculation. Takes in .weapon_acc, .skl, .skl_multiplier, .lck, lck_divisor. HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func _init(weap_acc:int, skl:int, skl_multplier:int, lck:int, lck_divisor:int) -> void:
	self.weap_acc = weap_acc
	self.skl = skl
	self.skl_multplier = skl_multplier
	self.lck = lck
	self.lck_divisor = lck_divisor
