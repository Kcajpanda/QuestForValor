##
extends Resource

class_name CombatPreview

##
var combat_calc:CombatCalc
## The attacking char
var char1: Character
## Weapon char1 has equipped.
var weap1:Weapon
## The defending char.
var char2:Character
## Weapon char2 has equipped.
var weap2: Weapon
## Tile char2 is on.
var tile2:Tile

##
var char1_atck_stat:Array[int]
##
var char2_atck_stat:Array[int]

##
func _init(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> void:
	self.char1 = char1
	self.weap1 = weap1
	self.char2 = char2
	self.weap2 = weap2
	self.tile2 = tile2
	combat_calc = CombatCalc.new()

##
func _calc_stats(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> Array[int]:
	var crit_acc:int = combat_calc.crit_accuracy(self.char1, self.weap1, self.char2)
	hitrate = combat_calc.hitrate(char1, weap1)
	avoid = combat_calc.avoid(char2, weap2, tile2 )
	damage = combat_calc.damage(char1, weap1, char2, weap2, tile2)

# Panel

##
func half_panel(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> Array[int]:
	var hit = self.hitrate(char1, weap1)
	var dmg = self.damage(char1, weap1, char2, weap2, tile2)
	var crit = self.crit_accuracy(char1, weap1, char2)
	var number_attack:int = self.num_attack(char1, char2)
	return [hit, dmg, crit, number_attack]
	
##
func str_half_panel(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> String:
	var char_proj:Array[int] = self.half_panel(char1, weap1, char2, weap2, tile2)
	return char1.char_name + ":\nhit | " + str(char_proj[0]) + "\ndmg | " + str(char_proj[1]) + "\ncrit | " + str(char_proj[2]) + "\nnum_attack | " + str(char_proj[3])
