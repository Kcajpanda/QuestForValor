## Event for the calculation of crit_avoid(). Takes in and stores the value of char_lck:int. When calc() is called it computes crit_avoid. Critical Avoid = Luck + Support Bonus.extends Event
class_name CalcCritAvoid

## char.lck.val
var char_lck:AlteredVal
## crit avoid.
var crit_avoid:AlteredVal

## Event for the calculation of crit_avoid(). Takes in and stores the value of char_lck:int. When calc() is called it computes crit_avoid. Critical Avoid = Luck + Support Bonus.
func _init(char_lck:int) -> void:
	self.char_lck = AlteredVal.new(char_lck)

## Critical Avoid = Luck + Support Bonus.
func calc() -> void:
	var result = char_lck.alter_val
	crit_avoid = AlteredVal.new(result) 
