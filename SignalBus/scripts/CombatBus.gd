extends Node

# Combat


# Tri-bonus
## Allows for changes to a characters rank with a weapon represented as char.weap_rnk(weap1.id) 
signal before_calc_tri_bonuses_char_rnk(event)
## Allows for changes to input param tri_bonus, representing who has triangle advantage over another.
signal before_calc_tri_bonuses_who_avd(event)
## Allows for changes to the stat advantages returned by who has tri_bonus and the attackers chars weap rnk.
signal after_calc_tri_bonuses_chng_advs(event)

# Combat Speed
## Allows for changes to the input params of combat speed: char.spd.val, char.strn.val, weap.wght.val.
signal before_calc_combat_speed(event:CalcCombatSpeed)

# Num-Attack
## Allows for changes to initial char speeds.
signal calc_num_attack_spds(event:CalcNumAttack)
## Allows for changes to the diff between the two char speeds post its orignal calculation.
signal after_calc_num_attack_spd_diff(event:CalcNumAttack)
## Allows for changes to the constants affecting the number of attacks a player can have.
signal after_calc_num_attack_eval(event:CalcNumAttack)

# Hitrate
## Allows for changes to input params and constants for hitrate(): weap.acc.val, char.skl.val, skl_multiplier, char.lck.val, lck_divisor
signal before_calc_hitrate(event:CalcHitrate)

# Avoid
## Allows for changes to input params and constants for avoid(): combat_spd, combat_spd_mult, char.lck.val, tile.dge.val.
signal before_calc_avoid(event:CalcAvoid)

# Accuracy
## Allows for changes to be made to input params for accuracy(): .hitrate(), .tri_bonuses(), .avoid().
signal before_calc_accuracy(event:CalcAccuracy)

# Attack Power
## Allows for changes to be made to input to char1.strn.val, weap1.wght.val, tri_bonuses(), char2.get_weap_eff().
signal before_calc_attack_power(event:CalcAttackPower)

# Defense Power
## Allows for changes to be made to the value of tile.defn.val, which_stat, char.defn.val, and char.defn.val.
signal before_calc_defense_power(event:CalcDefensePower)

# Damage

## Allows for changes to be made to the values of self.attack_power() and self.defense_power() in the damage calculation.
signal before_calc_damage(event:CalcDamage)

# Critical Damage
## Allows for changes to be made to the values of self.damage(char1, weap1, char2, weap2, tile2), and crit_dmg_mult = 3.
signal before_calc_crit_damage(event:CalcCritDamage)

# Critcal Rate
## Allows for changes to be made to the values of weap.crit.val, char.skl.val, and skl_divisor = 2
signal before_calc_crit_rate(event:CalcCritRate)

# Critical Avoid
## Allows for changes to be made to the values of char.lck.val.
signal before_calc_crit_avoid(event:CalcCritAvoid)

# Critical Accuracy
## Allows for changes to be made to the values of self.crit_rate(char1, weap1) and self.crit_avoid(char2).
signal before_calc_crit_accuracy(event:CalcCritAccuracy)

# In Combat

##
signal after_roll(event:AttackContext)
## Attack has been rolled and its state determined.
signal attack_result(event)
