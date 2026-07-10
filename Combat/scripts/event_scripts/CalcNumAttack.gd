## ## Event for NumAttack calculation. Contains .char1_spd, .char2_spd, attack_III, attack_III, and later through calculation .diff.
extends Event

class_name CalcNumAttack

## Speed for char1
var char1_spd:int
## Speed for char2
var char2_spd:int
## val representign the differnce bewteen char1_spd and char2_spd
var diff:int
## Combat Constant representign what val of char1_spd - char2_spd is needed for 3 attacks.
var attack_III:int
## Combat Constant representign what val of char1_spd - char2_spd is needed for 2 attacks.
var attack_II:int

## Event for NumAttack calculation. Contains .char1_spd, .char2_spd, attack_III, attack_III, and later through calculation .diff.
func _init(char1_spd:int, char2_spd:int, attack_III:int, attack_II:int) -> void:
	self.char1_spd = char1_spd
	self.char2_spd = char2_spd
	self.attack_III = attack_III
	self.attack_II = attack_II

## Calculates diff inside Event to account for chnages to char spds.
func calc_diff() -> void:
	diff = char1_spd - char2_spd
