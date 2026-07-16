## Event for when an Attack obj is created. Takes in the 
extends InviteEvent

class_name AttackContext

## ._roll_die()
var rolled:int
##
var hit:int
##
var dge:int
##
var crit:int

##
func _init(rolled:int, hit:int, dge:int, crit:int) -> void:
	self.rolled = rolled
	self.hit = hit
	self.dge = dge
	self.crit = crit
