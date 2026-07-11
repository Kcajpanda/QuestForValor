## Event for .accuracy() calculation. Takes in and stores hitrate:float, tri_bonuses:int, avoid:float. Whne calc() is called, it computes the val of accuracy. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus
extends Event

class_name CalcAccuracy

## Attacking char hitrate().
var hitrate:AlteredVal
## Attacking char tri_bonuses(). 
var tri_bonuses:AlteredVal
## Defending char avoid().
var avoid:AlteredVal
## accuracy
var accuracy:AlteredVal

## Event for .accuracy() calculation. Takes in and stores hitrate:float, tri_bonuses:int, avoid:float. Whne calc() is called, it computes the val of accuracy. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus
func _init(hitrate:float, tri_bonuses:int, avoid:float) -> void:
	self.hitrate = AlteredVal.new(hitrate)
	self.tri_bonuses = AlteredVal.new(tri_bonuses)
	self.avoid = AlteredVal.new(avoid)

## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus
func calc() -> void:
	var result = hitrate.alter_val + tri_bonuses.alter_val - avoid.alter_val
	accuracy = AlteredVal.new(result)
