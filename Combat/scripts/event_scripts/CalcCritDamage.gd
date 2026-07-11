## Event for crit_damage(). Takes in and stores dmg:int and crit_dmg_mult:int. When calc() is called it computers crit_damage. Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
extends Event

class_name CalcCritDamage

## self.damage(char1, weap1, char2, weap2, tile2)
var dmg:AlteredVal
## crit_dmg_mult = 3
var crit_dmg_mult:AlteredVal
## critical damage.
var crit_damage:AlteredVal

## Event for crit_damage(). Takes in and stores dmg:int and crit_dmg_mult:int. When calc() is called it computers crit_damage. Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func _init(dmg:int, crit_dmg_mult:int) -> void:
	self.dmg = AlteredVal.new(dmg)
	self.crit_dmg_mult = AlteredVal.new(crit_dmg_mult)

## Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func calc() -> void:
	var result = dmg.alter_val * crit_dmg_mult.alter_val
	crit_damage = AlteredVal.new(result)
