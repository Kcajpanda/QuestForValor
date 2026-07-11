## Event for damage() calculation. Takes in and stores the val of attack_power:int and defense_power:int. When .calc() is called it computes .damage. Damage = Attack Power (attacker) - Defense Power (defender).
extends CombatCalcEvent

class_name CalcDamage

## Combat.attack_power(char1, weap1, char2, weap2)
var attack_power:AlteredVal
## Combat.defense_power(char2, tile2, char2.is_magic())
var defense_power:AlteredVal
## damage
var damage:AlteredVal

## Event for damage() calculation. Takes in and stores the val of attack_power:int and defense_power:int. When .calc() is called it computes .damage. Damage = Attack Power (attacker) - Defense Power (defender).
func _init(attack_power:int, defense_power:int) -> void:
	self.attack_power = AlteredVal.new(attack_power)
	self.defense_power = AlteredVal.new(defense_power)

## Damage = Attack Power (attacker) - Defense Power (defender).
func calc() -> void:
	damage = AlteredVal.new(attack_power.alter_val - defense_power.alter_val)
