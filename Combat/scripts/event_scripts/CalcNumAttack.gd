## Event for NumAttack calculation. Contains .char1_spd, .char2_spd, attack_III, attack_III, and later through calculation .diff. When calc() is called, it computes num_attack.
extends Event

class_name CalcNumAttack

## Speed for char1
var char1_spd:AlteredVal
## Speed for char2
var char2_spd:AlteredVal
## val representign the differnce bewteen char1_spd and char2_spd
var diff:AlteredVal
## Combat Constant representign what val of char1_spd - char2_spd is needed for 3 attacks.
var attack_III:AlteredVal
## Combat Constant representign what val of char1_spd - char2_spd is needed for 2 attacks.
var attack_II:AlteredVal
## number of attacks.
var num_attack:AlteredVal

## Event for NumAttack calculation. Contains .char1_spd, .char2_spd, attack_III, attack_III, and later through calculation .diff. When calc() is called, it computes num_attack.
func _init(char1_spd:int, char2_spd:int, attack_III:int, attack_II:int) -> void:
	self.char1_spd = AlteredVal.new(char1_spd)
	self.char2_spd = AlteredVal.new(char2_spd)
	self.attack_III = AlteredVal.new(attack_III)
	self.attack_II = AlteredVal.new(attack_II)

## Calculates diff inside Event to account for chnages to char spds.
func calc_diff() -> void:
	diff = AlteredVal.new(char1_spd.alter_val - char2_spd.alter_val)

## Computes num_attack.
func calc() -> void:
	var result:int
	if diff.alter_val >= attack_III.alter_val:
		result = 3
	elif diff.alter_val >= attack_II.alter_val:
		result = 2
	else:
		result = 1
	num_attack = AlteredVal.new(result)
