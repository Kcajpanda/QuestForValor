## Event for damage() calculation. Takes in and stores the val of attack_power:int and defense_power:int. Damage = Attack Power (attacker) - Defense Power (defender).
extends Event

class_name CalcDamage

## Combat.attack_power(char1, weap1, char2, weap2)
var attack_power:int
## Combat.defense_power(char2, tile2, char2.is_magic())
var defense_power:int

## Event for damage() calculation. Takes in and stores the val of attack_power:int and defense_power:int. Damage = Attack Power (attacker) - Defense Power (defender).
func _init(attack_power:int, defense_power:int) -> void:
	self.attack_power = attack_power
	self.defense_power = defense_power
