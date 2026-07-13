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


## Returns the Array[int] of Tri bonuses [acc, dmg]
func tri_bonuses(char:Character, weap:Weapon, tri_bonus:int) -> AlteredVal:
	var trib_event = CalcTriBonus.new(char.weap_rnk(weap.id), tri_bonus, )
	CombatBus.before_calc_tri_bonuses_char_rnk.emit(trib_event)
	CombatBus.before_calc_tri_bonuses_who_avd.emit(trib_event)
	
	trib_event.get_tri_adv(weap)
	CombatBus.after_calc_tri_bonuses_chng_advs.emit(trib_event)
	
	return trib_event.tri_adv

## AS = spd - (str - Weapon_weight)
func combat_speed(char:Character, weap:Weapon) -> AlteredVal:
	var cs_event = CalcCombatSpeed.new(char.spd.val, char.strn.val, weap.wght.val)
	CombatBus.before_calc_combat_speed.emit(cs_event)
	
	cs_event.calc()
	return cs_event.combat_speed

## Number of times a char can attack, only one char can atack multiple times, whoever scores higher in the equation below
func num_attack(char1:Character, char2:Character) -> AlteredVal:
	var na_event = CalcNumAttack.new(char1.spd.val, char2.spd.val, MULTI_ATTACK_III, MULTI_ATTACK_II)
	CombatBus.calc_num_attack_spds.emit(na_event)
	
	na_event.calc_diff()
	CombatBus.after_calc_num_attack_spd_diff.emit(na_event)
	
	na_event.calc()
	CombatBus.after_calc_num_attack_eval.emit(na_event)
	return na_event.num_attack

## HIT = Weapon Accuracy + Skill x 2 + Luck / 2 + Other Bonus
func hitrate(char:Character, weap:Weapon) -> AlteredVal:
	var h_event = CalcHitrate.new(weap.acc.val, char.skl.val, 2, char.lck.val, 2)
	CombatBus.before_calc_hitrate.emit(h_event)
	
	h_event.calc()
	return h_event.hitrate

## Avoid = Attack Speed x 2 + Luck + Terrain Bonus + Other Bonus	
func avoid(char:Character, weap:Weapon, tile:Tile) -> AlteredVal:
	var av_event = CalcAvoid.new(self.combat_speed(char, weap).alt_val, 2, char.lck.val, tile.dge.val)
	CombatBus.before_calc_avoid.emit(av_event)
	
	av_event.calc()
	return av_event.avoid

## Accuracy = Hit Rate (Attacker) - Evade (Defender) + Triangle Bonus acc
func accuracy(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var acc_event = CalcAccuracy.new(self.hitrate(char1, weap1).alter_val, tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id)).alter_val[0], self.avoid(char2, weap2, tile2).alter_val)
	CombatBus.before_calc_accuracy.emit(acc_event)
	
	acc_event.calc()
	return acc_event.accuracy

## Physical Attack = Strength + (Weapon Might + Weapon Triangle Bonus) * Weapon effectiveness + Support Bonus
#TODO include tile bonus for attacker?
func attack_power(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon) -> AlteredVal:
	var ap_event = CalcAttackPower.new(char1.strn.val, weap1.wght.val, tri_bonuses(char1, weap1, weap1.tri_bonus(weap2.id) ).alter_val[1], char2.get_weap_eff(weap1.id))
	CombatBus.before_calc_attack_power.emit(ap_event)
	
	ap_event.calc()
	return ap_event.attack_power

## Defense Power = Terrain Bonus + Defense + Support Bonus
func defense_power(char:Character, tile:Tile, which_stat:bool) -> AlteredVal:
	var dp_event = CalcDefensePower.new(tile.defn.val, which_stat, char.defn.val, char.defn.val)
	CombatBus.before_calc_defense_power.emit(dp_event)
	
	dp_event.calc()
	return dp_event.defense_power

## Damage = Attack Power (attacker) - Defense Power (defender)
func damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var d_event = CalcDamage.new(self.attack_power(char1, weap1, char2, weap2).alter_val, self.defense_power(char2, tile2, char2.is_magic()).alter_val)
	CombatBus.before_calc_damage.emit(d_event)
	
	d_event.calc()
	return d_event.damage

# Critical hits


## Critical Damage = [Attack Power (attacker) - Defense Power (defender)] * 3
func crit_damage(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile) -> AlteredVal:
	var c_dmg_event = CalcCritDamage.new(self.damage(char1, weap1, char2, weap2, tile2).alter_val, 3)
	CombatBus.before_calc_crit_damage.emit(c_dmg_event)
	
	c_dmg_event.calc()
	return c_dmg_event.crit_damage

## Critical Rate = Weapon Critical + Skill / 2 + Other Bonus
func crit_rate(char:Character, weap:Weapon) -> AlteredVal:
	var c_rate_event = CalcCritRate.new(weap.crit.val, char.skl.val, 2)
	CombatBus.before_calc_crit_rate.emit(c_rate_event)
	
	c_rate_event.calc()
	return c_rate_event.crit_rate

## Critical Avoid = Luck + Support Bonus
func crit_avoid(char:Character) -> AlteredVal:
	var c_avoid_event = CalcCritAvoid.new(char.lck.val)
	CombatBus.before_calc_crit_avoid.emit(c_avoid_event)
	
	c_avoid_event.calc()
	return c_avoid_event.crit_avoid

## Critical Accuracy (char1) = Critical Rate (char1) - Critical Avoid (char2)
func crit_accuracy(char1:Character, weap1:Weapon, char2:Character) -> AlteredVal:
	var c_acc_event = CalcCritAccuracy.new(self.crit_rate(char1, weap1).alter_val, self.crit_avoid(char2).alter_val)
	CombatBus.before_calc_crit_accuracy.emit(c_acc_event)
	
	c_acc_event.calc()
	return c_acc_event.crit_acc
