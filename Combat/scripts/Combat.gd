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
	pass
	#self.char1 = char1
	#self.weap1 = weap1
	#self.char2 = char2
	#self.weap2 = weap2
	#self.tile1 = tile1
	#self.tile2 = tile2
	#self.rng = RandomNumberGenerator.new()
	#self.attacks = []

###
#func fight():
	#var char1_num_atck:int = self.num_attack(self.char1, self.char2)
	#var char2_num_atck:int = self.num_attack(self.char2, self.char1)
	#
	#var atck_1_stats = self.get_stats(self.char1, self.weap1, self.char2, self.weap2, self.tile2)
	#var atck_1 = Attack.new(self.char1, self.weap1, self.char2, self.weap2, self.tile2, atck_1_stats)
	#
###
#func can_fight() -> bool:
	#return true

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

## Allows for changes to a characters rank with a weapon represented as char.weap_rnk(weap1.id) 
signal before_calc_tri_bonuses_char_rnk(event)
## Allows for changes to input param tri_bonus, representign who has triangle advantage over another.
signal before_calc_tri_bonuses_who_avd(event)
## Allows for changes to the stat advantages returned by who has tri_bonus and the attackers chars weap rnk.
signal after_calc_tri_bonuses_chng_advs(event)
## Returns the Array[int] of Tri bonuses [acc, dmg]
func tri_bonuses(char:Character, weap:Weapon, tri_bonus:int) -> Array[int]:
	var trib_event = CalcTriBonus.new(char.weap_rnk(weap1.id), tri_bonus, )
	before_calc_tri_bonuses_char_rnk.emit(trib_event)
	before_calc_tri_bonuses_who_avd.emit(trib_event)
	
	trib_event.get_tri_adv(weap)
	after_calc_tri_bonuses_chng_advs.emit(trib_event)
	
	return trib_event.tri_adv

## Allows for changes to the input params of combat speed: char.spd.val, char.strn.val, weap.wght.val.
signal before_calc_combat_speed(event:CalcCombatSpeed)
## AS = spd - (str - Weapon_weight)
func combat_speed(char:Character, weap:Weapon) -> float:
	var cs_event = CalcCombatSpeed.new(char.spd.val, char.strn.val, weap.wght.val)
	before_calc_combat_speed.emit(cs_event)
	return cs_event.spd - ( cs_event.strn - cs_event.weapon_wght )

## Allows for changes to initial char speeds.
signal calc_num_attack_spds(event:CalcNumAttack)
## Allows for changes to the diff between the two char speeds post its orignal calculation.
signal after_calc_num_attack_spd_diff(event:CalcNumAttack)
## Allows for changes to the constants affecting the number of attacks a player can have.
signal before_calc_num_attack_eval(event:CalcNumAttack)

## Number of times a char can attack, only one char can atack multiple times, whoever scores higher in the equation below
func num_attack(char1:Character, char2:Character) -> int:
	var na_event = CalcNumAttack.new(char1.spd.val, char2.spd.val, MULTI_ATTACK_III, MULTI_ATTACK_II)
	calc_num_attack_spds.emit(na_event)
	
	na_event.calc_diff()
	after_calc_num_attack_spd_diff.emit(na_event)
	
	before_calc_num_attack_eval.emit(na_event)
	if na_event.diff >= na_event.attack_III:
		return 3
	elif na_event.diff >= na_event.attack_II:
		return 2
	else:
		return 1

## Allows for changes to input params and constants for hitrate(): weap.acc.val, char.skl.val, skl_multiplier, char.lck.val, lck_divisor
signal before_calc_hitrate(event:CalcHitrate)
## HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func hitrate(char:Character, weap:Weapon) -> float:
	var h_event = CalcHitrate.new(weap.acc.val, char.skl.val, 2, char.lck.val, 2)
	before_calc_hitrate.emit(h_event)
	return h_event.weap_acc + (h_event.skl * h_event.skl_multplier) + float(h_event.lck / h_event.lck_divisor)

## Allows for changes to input params and constants for avoid(): combat_spd, combat_spd_mult, char.lck.val, tile.dge.val.
signal before_calc_avoid(event:CalcAvoid)
## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus	
func avoid(char:Character, weap:Weapon, tile:Tile) -> float:
	var av_event = CalcAvoid.new(self.combat_speed(char, weap), 2, char.lck.val, tile.dge.val)
	before_calc_avoid.emit(av_event)
	
	return float( av_event.combat_spd * av_event.combat_spd_mult + av_event.char_lck + av_event.tile_dge )

## Allows for changes to be made to input params for accuracy(): .hitrate(), .tri_bonuses(), .avoid().
signal before_calc_accuracy(event:CalcAccuracy)
## Accuracy = Hit Rate (Attacker) - Evade (Defender) + Triangle Bonus acc
func accuracy(char1:Character, weap1:Weapon, cha2:Character, weap2:Weapon, tile2:Tile) -> float:
	var acc_event = CalcAccuracy.new(self.hitrate(char1, weap1), tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id))[0], self.avoid(char2, weap2, tile2))
	before_calc_accuracy.emit(acc_event)
	
	return ( acc_event.hitrate + acc_event.tri_bonuses ) - acc_event.avoid

## Allows for changes to be made to input to char1.strn.val, weap1.wght.val, tri_bonuses(), char2.get_weap_eff().
signal before_calc_attack_power(event:CalcAttackPower)
## Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus
# include tile bonus for attacker?
func attack_power(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon) -> int:
	var ap_event = CalcAttackPower.new(char1.strn.val, weap1.wght.val, tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) )[1], char2.get_weap_eff(weap1.id))
	before_calc_attack_power.emit(ap_event)
	
	return ap_event.char1_strn + ( ap_event.weap1_wght + ap_event.tri_bonuses_dmg ) * ap_event.char2_weap_eff

## Allows for changes to be made to the value of tile.defn.val, which_stat, char.defn.val, and char.defn.val.
signal before_calc_defense_power(event:CalcDefensePower)
## Defense Power = Terrain Bonus + Defense + Support Bonus
func defense_power(char:Character, tile:Tile, which_stat:bool) -> int:
	var dp_event = CalcDefensePower.new(tile.defn.val, which_stat, char.defn.val, char.defn.val)
	before_calc_defense_power.emit(dp_event)
	
	var dp:int = dp_event.tile_defn
	if dp_event.which_stat: #defn
		dp += char.defn.val
	else: # res
		dp += char.res.val
	return dp

## Allows for changes to be made to the values of self.attack_power() and self.defense_power() in the damage calculation.
signal before_calc_damage(event:CalcDamage)
## Damage = Attack Power (attacker) - Defense Power (defender)
func damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> int:
	var d_event = CalcDamage.new(self.attack_power(char1, weap1, char2, weap2), self.defense_power(char2, tile2, char2.is_magic()))
	before_calc_damage.emit(d_event)
	
	return d_event.attack_power - d_event.defense_power

# Critical hits

## Allows for changes to be made to the values of self.damage(char1, weap1, char2, weap2, tile2), and crit_dmg_mult = 3.
signal before_calc_crit_damage(event:CalcCritDamage)
## Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func crit_damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> int:
	var c_dmg_event = CalcCritDamage.new(self.damage(char1, weap1, char2, weap2, tile2), 3)
	before_calc_crit_damage.emit(c_dmg_event)
	
	return c_dmg_event.dmg * c_dmg_event.crit_dmg_mult

## Allows for changes to be made to the values of weap.crit.val, char.skl.val, and skl_divisor = 2
signal before_calc_crit_rate(event:CalcCritRate)
## Critical Rate = Weapon Critical + Skill / 2 + Other Bonus
func crit_rate(char:Character, weap:Weapon) -> float:
	var c_rate_event = CalcCritRate.new(weap.crit.val, char.skl.val, 2)
	before_calc_crit_rate.emit(c_rate_event)
	
	return c_rate_event.weap_crit + c_rate_event.char_skl / c_rate_event.skl_divisor

## Allows for changes to be made to the values of char.lck.val.
signal before_calc_crit_avoid(event:CalcCritAvoid)
## Critical Avoid = Luck + Support Bonus
func crit_avoid(char:Character) -> int:
	var c_avoid_event = CalcCritAvoid.new(char.lck.val)
	before_calc_crit_avoid.emit(c_avoid_event)
	
	return c_avoid_event.char_lck

## Allows for changes to be made to the values of self.crit_rate(char1, weap1) and self.crit_avoid(char2).
signal before_calc_crit_accuracy(event:CalcCritAccuracy)
## Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2)
func crit_accuracy(char1:Character, weap1:Weapon, char2:Character) -> int:
	var c_acc_event = CalcCritAccuracy.new(self.crit_rate(char1, weap1), self.crit_avoid(char2))
	before_calc_crit_accuracy.emit(c_acc_event)
	
	return c_acc_event.crit_rate - c_acc_event.crit_avoid
