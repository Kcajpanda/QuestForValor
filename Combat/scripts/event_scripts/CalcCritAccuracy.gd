## Event for the calculation of crit_accuracy(). Takes in and stores the value of crit_rate:int and crit_avoid:int. Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2).
extends Event

class_name CalcCritAccuracy

## self.crit_rate(char1, weap1)
var crit_rate:int
## self.crit_avoid(char2)
var crit_avoid:int

## ## Event for the calculation of crit_accuracy(). Takes in and stores the value of crit_rate:int and crit_avoid:int. Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2).
func _init(crit_rate:int, crit_avoid:int) -> void:
	self.crit_rate = crit_rate
	self.crit_avoid = crit_avoid
