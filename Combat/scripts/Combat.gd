## obj used to manage a combat encouter and run relevent calc
extends Resource

class_name Combat

##
const MULTI_ATTACK_II:int = 4
##
const MULTI_ATTACK_III:int = 6
##
enum {CRIT, HIT, DODGE, MISS}

##
var char1: Character
##
var weap1: Weapon
##
var char2: Character
##
var weap2: Weapon
##
var tile1: Tile
##
var tile2: Tile
##
var rng: RandomNumberGenerator
##
var attacks: Array[Attack]

##
func _init(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile1:Tile, tile2:Tile) -> void:
	self.char1 = char1
	self.weap1 = weap1
	self.char2 = char2
	self.weap2 = weap2
	self.tile1 = tile1
	self.tile2 = tile2
	self.rng = RandomNumberGenerator.new()
	self.attacks = []

##
func fight():
	var char1_num_atck:int = self.num_attack(self.char1, self.char2)
	var char2_num_atck:int = self.num_attack(self.char2, self.char1)
	
	var atck_1_stats = self.get_stats(self.char1, self.weap1, self.char2, self.weap2, self.tile2)
	var atck_1 = Attack.new(self.char1, self.weap1, self.char2, self.weap2, self.tile2, atck_1_stats)
	
##
func can_fight() -> bool:
	return true

##
func get_stats(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> Array[int]:
	var crit:int = self.crit_accuracy(char1, weap1, char2)
	var hit:int = self.hitrate(char1, weap1)
	var dge:int = self.avoid(char2, weap2, tile2 )
	var dmg = self.damage(char1, weap1, char2, weap2, tile2)
	return [crit, hit, dge, dmg]

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

# Calc

## Returns the Array[int] of Tri bonuses [acc, dmg]
func tri_bonuses(char:Character, weap:Weapon, tri_bonus:int) -> Array[int]:
	var char_rnk = char.weap_rnk(weap1.id)
	
	if tri_bonus == 1:
		return weap.tri_advantages(true, char_rnk)
	elif tri_bonus == -1:
		return weap.tri_advantages(false, char_rnk)
	else:
		return [0,0]

## AS = spd - (str - Weapon_weight)
func combat_speed(char:Character, weap:Weapon) -> float:
	return char.spd.val - ( char.strn.val - weap.wght.val )
	
## Number of times a char can attack, only one char can atack multiple times, whoever scores higher in the equation below
func num_attack(char1:Character, char2:Character) -> int:
	var speed_diff = abs(char1.spd.val - char2.spd.val)
	if speed_diff >= MULTI_ATTACK_III:
		return 3
	elif speed_diff:
		return 2
	else:
		return 1

## HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func hitrate(char:Character, weap:Weapon) -> float:
	return weap.acc.val + (char.skl.val * 2) + (float(char.lck.val) / 2)

## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus	
func avoid(char:Character, weap:Weapon, tile:Tile) -> float:
	return self.combat_speed(char, weap) * 2 + char.lck.val + tile.dge.val
	
## Accuracy = Hit Rate (Attacker) - Evade (Defender) + Triangle Bonus acc
func accuracy(char1:Character, weap1:Weapon, cha2:Character, weap2:Weapon, tile2:Tile) -> float:
	return ( self.hitrate(char1, weap1) + tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id))[0]) - self.avoid(char2, weap2, tile2)

## Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus
# include tile bonus for attacker?
func attack_power(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon) -> int:
	return char1.strn.val + ( weap1.wght.val + tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) )[1] ) * char2.get_weap_eff(weap1.id)

## Defense Power = Terrain Bonus + Defense + Support Bonus
func defense_power(char:Character, tile:Tile, which_stat:bool) -> int:
	var dp = tile.defn
	if which_stat: #defn
		dp += char.defn
	else: # res
		dp += char.res
	return dp

## Damage = Attack Power (attacker) - Defense Power (defender)
func damage(char1:Character, weap1:Weapon, cha2:Character, weap2:Weapon, tile2:Tile) -> int:
	return self.attack_power(char1, weap1, char2, weap2) - self.defense_power(char2, tile2, char2.is_magic())

# Critical hits

## Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func crit_damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> int:
	return self.damage(char1, weap1, char2, weap2, tile2) * 3

## Critical Rate = Weapon Critical + Skill / 2 + Other Bonus
func crit_rate(char:Character, weap:Weapon) -> float:
	return weap.crit.val + char.skl.val / 2

## Critical Avoid = Luck + Support Bonus
func crit_avoid(char:Character) -> int:
	return char.lck.val
	
## Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2)
func crit_accuracy(char1:Character, weap1:Weapon, char2:Character) -> int:
	return int(self.crit_rate(char1, weap1) - self.crit_avoid(char2))
