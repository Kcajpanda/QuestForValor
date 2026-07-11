##
extends Resource

class_name CharCombatPreview

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
var is_tri_bonus:AlteredVal
##
var tri_bonus:AlteredVal
##
var combat_speed:AlteredVal
##
var num_attack:AlteredVal
##
var hitrate:AlteredVal
##
var avoid:AlteredVal
##
var accuracy:AlteredVal
##
var attack_power:AlteredVal
##
var defense_power:AlteredVal
##
var damage:AlteredVal
##
var crit_dmg:AlteredVal
##
var crit_acc:AlteredVal

##
var str_half_panel:String

##
func _init(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> void:
	self.char1 = char1
	self.weap1 = weap1
	self.char2 = char2
	self.weap2 = weap2
	self.tile2 = tile2
	
	combat_calc = CombatCalc.new()
	combat_calc.before_calc_damage.connect(_on_before_calc_damage) # Grabs Attack power and Defense Power
	combat_calc.before_calc_defense_power.connect(_on_before_calc_defense_power) # Grabs
	
	self._calc_core_stat()

##
func _calc_core_stat() -> void:
	damage = combat_calc.damage(char1, weap1, char2, weap2, tile2)
	accuracy = combat_calc.accuracy(char1, weap1, char2, weap2, tile2)
	crit_dmg = combat_calc.crit_damage(char1, weap1, char2, weap2, tile2)
	crit_acc = combat_calc.crit_accuracy(char1, weap1, char2)

##
func _on_before_calc_damage(event:CalcDamage) -> void:
	attack_power = event.attack_power.alter_val
	defense_power = event.defense_power.alter_val

##
func _on_before_calc_defense_power(event:CalcDefensePower) -> void:
	pass
##
func _gen_str_half_panel() -> void:
	str_half_panel = char1.char_name + ":\nhit | " + str(hitrate) + "\ndmg | " + str(damage) + "\ncrit | " + str(crit_acc) + "\nnum_attack | " + str(num_attack)
