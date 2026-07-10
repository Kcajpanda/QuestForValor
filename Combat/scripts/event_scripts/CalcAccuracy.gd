## Event for .accuracy() calculation. Takes in and stores hitrate:float, tri_bonuses:int, avoid:float. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus
extends Event

class_name CalcAccuracy

## Attacking char hitrate().
var hitrate:float
## Attacking char tri_bonuses(). 
var tri_bonuses:int
## Defending char avoid().
var avoid:float

## ## Event for .accuracy() calculation. Takes in and stores hitrate:float, tri_bonuses:int, avoid:float. Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus
func _init(hitrate:float, tri_bonuses:int, avoid:float) -> void:
	self.hitrate = hitrate
	self.tri_bonuses = tri_bonuses
	self.avoid = avoid
