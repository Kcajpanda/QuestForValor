## obj used to run combat calculations
extends Resource

class_name CombatCalc

##
const MULTI_ATTACK_II:int = 4
##
const MULTI_ATTACK_III:int = 6
##
enum {CRIT, HIT, DODGE, MISS}


##
func _init() -> void:
	pass

# Calc

## Allows for changes to a characters rank with a weapon represented as char.weap_rnk(weap1.id) 
signal before_calc_tri_bonuses_char_rnk(event)
## Allows for changes to input param tri_bonus, representign who has triangle advantage over another.
signal before_calc_tri_bonuses_who_avd(event)
## Allows for changes to the stat advantages returned by who has tri_bonus and the attackers chars weap rnk.
signal after_calc_tri_bonuses_chng_advs(event)
## Returns the Array[int] of Tri bonuses [acc, dmg]
func tri_bonuses(char:Character, weap:Weapon, tri_bonus:int) -> AlteredVal:
	var trib_event = CalcTriBonus.new(char.weap_rnk(weap.id), tri_bonus, )
	before_calc_tri_bonuses_char_rnk.emit(trib_event)
	before_calc_tri_bonuses_who_avd.emit(trib_event)
	
	trib_event.get_tri_adv(weap)
	after_calc_tri_bonuses_chng_advs.emit(trib_event)
	
	return trib_event.tri_adv

## Allows for changes to the input params of combat speed: char.spd.val, char.strn.val, weap.wght.val.
signal before_calc_combat_speed(event:CalcCombatSpeed)
## AS = spd - (str - Weapon_weight)
func combat_speed(char:Character, weap:Weapon) -> AlteredVal:
	var cs_event = CalcCombatSpeed.new(char.spd.val, char.strn.val, weap.wght.val)
	before_calc_combat_speed.emit(cs_event)
	
	cs_event.calc()
	return cs_event.combat_speed

## Allows for changes to initial char speeds.
signal calc_num_attack_spds(event:CalcNumAttack)
## Allows for changes to the diff between the two char speeds post its orignal calculation.
signal after_calc_num_attack_spd_diff(event:CalcNumAttack)
## Allows for changes to the constants affecting the number of attacks a player can have.
signal after_calc_num_attack_eval(event:CalcNumAttack)
## Number of times a char can attack, only one char can atack multiple times, whoever scores higher in the equation below
func num_attack(char1:Character, char2:Character) -> AlteredVal:
	var na_event = CalcNumAttack.new(char1.spd.val, char2.spd.val, MULTI_ATTACK_III, MULTI_ATTACK_II)
	calc_num_attack_spds.emit(na_event)
	
	na_event.calc_diff()
	after_calc_num_attack_spd_diff.emit(na_event)
	
	na_event.calc()
	after_calc_num_attack_eval.emit(na_event)
	return na_event.num_attack

## Allows for changes to input params and constants for hitrate(): weap.acc.val, char.skl.val, skl_multiplier, char.lck.val, lck_divisor
signal before_calc_hitrate(event:CalcHitrate)
## HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func hitrate(char:Character, weap:Weapon) -> AlteredVal:
	var h_event = CalcHitrate.new(weap.acc.val, char.skl.val, 2, char.lck.val, 2)
	before_calc_hitrate.emit(h_event)
	
	h_event.calc()
	return h_event.hitrate

## Allows for changes to input params and constants for avoid(): combat_spd, combat_spd_mult, char.lck.val, tile.dge.val.
signal before_calc_avoid(event:CalcAvoid)
## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus	
func avoid(char:Character, weap:Weapon, tile:Tile) -> AlteredVal:
	var av_event = CalcAvoid.new(self.combat_speed(char, weap).alt_val, 2, char.lck.val, tile.dge.val)
	before_calc_avoid.emit(av_event)
	
	av_event.calc()
	return av_event.avoid

## Allows for changes to be made to input params for accuracy(): .hitrate(), .tri_bonuses(), .avoid().
signal before_calc_accuracy(event:CalcAccuracy)
## Accuracy = Hit Rate (Attacker) - Evade (Defender) + Triangle Bonus acc
func accuracy(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var acc_event = CalcAccuracy.new(self.hitrate(char1, weap1).alter_val, tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id)).alter_val[0], self.avoid(char2, weap2, tile2).alter_val)
	before_calc_accuracy.emit(acc_event)
	
	acc_event.calc()
	return acc_event.accuracy

## Allows for changes to be made to input to char1.strn.val, weap1.wght.val, tri_bonuses(), char2.get_weap_eff().
signal before_calc_attack_power(event:CalcAttackPower)
## Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus
# include tile bonus for attacker?
func attack_power(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon) -> AlteredVal:
	var ap_event = CalcAttackPower.new(char1.strn.val, weap1.wght.val, tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) ).alter_val[1], char2.get_weap_eff(weap1.id))
	before_calc_attack_power.emit(ap_event)
	
	ap_event.calc()
	return ap_event.attack_power

## Allows for changes to be made to the value of tile.defn.val, which_stat, char.defn.val, and char.defn.val.
signal before_calc_defense_power(event:CalcDefensePower)
## Defense Power = Terrain Bonus + Defense + Support Bonus
func defense_power(char:Character, tile:Tile, which_stat:bool) -> AlteredVal:
	var dp_event = CalcDefensePower.new(tile.defn.val, which_stat, char.defn.val, char.defn.val)
	before_calc_defense_power.emit(dp_event)
	
	dp_event.calc()
	return dp_event.defense_power

## Allows for changes to be made to the values of self.attack_power() and self.defense_power() in the damage calculation.
signal before_calc_damage(event:CalcDamage)
## Damage = Attack Power (attacker) - Defense Power (defender)
func damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var d_event = CalcDamage.new(self.attack_power(char1, weap1, char2, weap2).alter_val, self.defense_power(char2, tile2, char2.is_magic()).alter_val)
	before_calc_damage.emit(d_event)
	
	d_event.calc()
	return d_event.damage

# Critical hits

## Allows for changes to be made to the values of self.damage(char1, weap1, char2, weap2, tile2), and crit_dmg_mult = 3.
signal before_calc_crit_damage(event:CalcCritDamage)
## Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func crit_damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var c_dmg_event = CalcCritDamage.new(self.damage(char1, weap1, char2, weap2, tile2).alter_val, 3)
	before_calc_crit_damage.emit(c_dmg_event)
	
	c_dmg_event.calc()
	return c_dmg_event.crit_damage

## Allows for changes to be made to the values of weap.crit.val, char.skl.val, and skl_divisor = 2
signal before_calc_crit_rate(event:CalcCritRate)
## Critical Rate = Weapon Critical + Skill / 2 + Other Bonus
func crit_rate(char:Character, weap:Weapon) -> AlteredVal:
	var c_rate_event = CalcCritRate.new(weap.crit.val, char.skl.val, 2)
	before_calc_crit_rate.emit(c_rate_event)
	
	c_rate_event.calc()
	return c_rate_event.crit_rate

## Allows for changes to be made to the values of char.lck.val.
signal before_calc_crit_avoid(event:CalcCritAvoid)
## Critical Avoid = Luck + Support Bonus
func crit_avoid(char:Character) -> AlteredVal:
	var c_avoid_event = CalcCritAvoid.new(char.lck.val)
	before_calc_crit_avoid.emit(c_avoid_event)
	
	c_avoid_event.calc()
	return c_avoid_event.crit_avoid

## Allows for changes to be made to the values of self.crit_rate(char1, weap1) and self.crit_avoid(char2).
signal before_calc_crit_accuracy(event:CalcCritAccuracy)
## Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2)
func crit_accuracy(char1:Character, weap1:Weapon, char2:Character) -> AlteredVal:
	var c_acc_event = CalcCritAccuracy.new(self.crit_rate(char1, weap1).alter_val, self.crit_avoid(char2).alter_val)
	before_calc_crit_accuracy.emit(c_acc_event)
	
	c_acc_event.calc()
	return c_acc_event.crit_acc
