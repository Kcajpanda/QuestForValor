## Event for crit_damage(). Takes in and stores dmg:int and crit_dmg_mult:int. Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
extends Event

class_name CalcCritDamage

## self.damage(char1, weap1, char2, weap2, tile2)
var dmg:int
## crit_dmg_mult = 3
var crit_dmg_mult:int

## Event for crit_damage(). Takes in and stores dmg:int and crit_dmg_mult:int. Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func _init(dmg:int, crit_dmg_mult:int) -> void:
	self.dmg = dmg
	self.crit_dmg_mult = crit_dmg_mult
