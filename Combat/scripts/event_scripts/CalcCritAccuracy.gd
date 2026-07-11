## Event for the calculation of crit_accuracy(). Takes in and stores the value of crit_rate:int and crit_avoid:int. When calc() is caled, it computes the val for crit_acc. Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2).
extends Event

class_name CalcCritAccuracy

## self.crit_rate(char1, weap1)
var crit_rate:AlteredVal
## self.crit_avoid(char2)
var crit_avoid:AlteredVal
## crit accuracy.
var crit_acc:AlteredVal

## Event for the calculation of crit_accuracy(). Takes in and stores the value of crit_rate:int and crit_avoid:int. When calc() is caled, it computes the val for crit_acc. Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2).
func _init(crit_rate:int, crit_avoid:int) -> void:
	self.crit_rate = AlteredVal.new(crit_rate)
	self.crit_avoid = AlteredVal.new(crit_avoid)

## Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2).
func calc() -> void:
	var result = crit_rate.alter_val - crit_avoid.alter_val
	crit_acc = AlteredVal.new(result)
