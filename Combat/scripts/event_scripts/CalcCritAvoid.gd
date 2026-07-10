## Event for the calculation of crit_avoid(). Takes in and stores the value of char_lck:int. Critical Avoid = Luck + Support Bonus.
extends Event

class_name CalcCritAvoid

## char.lck.val
var char_lck:int

## Event for the calculation of crit_avoid(). Takes in and stores the value of char_lck:int. Critical Avoid = Luck + Support Bonus.
func _init(char_lck:int) -> void:
	self.char_lck = char_lck
