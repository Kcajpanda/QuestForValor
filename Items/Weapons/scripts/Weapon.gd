## Extension of the Item class containing methods and properties relevant to weapons.
class_name Weapon

extends Item

## Takes in self.rq_rnk and returns the str_rq_rnk, used for generating str_rq_rnk
const WEAPON_RANK = {
	0: "E",
	1: "D",
	2: "C",
	3: "B",
	4: "A",
	5: "S",
	6: "M"
}

## Takes in self.type and returns weap type in string
const WEAPON_TYPE = {
	0: "Sword",
	1: "Axe",
	2: "Lance",
	3: "Stave",
	4: "Anima",
	5: "Light",
	6: "Eldritch"
}

enum advantage {ADV, NUETRAL, DISADV}
## Matrix that takes in row=weap1, and col=weap2 => advantage for weap1.
const TRI_BONUS = [
	[ 0, 1, -1, 0, 0, 0], #Sword
	[ -1, 0, 1, 0, 0, 0], #Axe
	[ 1, -1, 0, 0, 0, 0], #Lance
	[ 0, 0, 0, 0, 1, -1], #Anima
	[ 0, 0, 0, -1, 0, 1], #Light
	[ 0, 0, 0, 1, -1, 0] #Eldritch
]

## Dictionary used to determine bonus to acc and dmg for those at advantage and disadvantage in the weapon-tri, neutral get no adv or dis regardless of weap rnk. 
const RANK_ADVANTAGES = { ## [ [adv_acc, adv_dmg], [dis_acc, dis_dmg] ]
	0: [ [5, 0], [-5, 0] ],
	1: [ [5, 0], [-5, 0] ],
	2: [ [10, 0], [-10, 0] ],
	3: [ [10, 0], [-10, 0] ],
	4: [ [10, 1], [-10, -1] ],
	5: [ [15, 1], [-15, -1] ],
	6: [ [15, 2], [-15, -2] ],
}

## Takes in self.id and returns its damage type Physical/Magic true/false
const DMG_TYPE = {
	0: true, #Sword
	1: true, #Axe
	2: true, #Lance
	3: false, #Anima
	4: false, #Light
	5: false, #Eldritch
}

# Immutables
## Required Rank, represent the needed skill rank needed to wield a given weapon.
var rq_rnk : int
## (String) Required Rank, represent the needed skill rank needed to wield a given weapon. Determined by const WEAPON_RANK.
var str_rq_rnk : String
## The type of damage a weapon deals Physical/Magic true/false
var dmg_type: bool
## Range the weapon can attack in.
var atck_range: int

# Mutables with associated temp vals
## Might, or power, associated with the Weapon instance, used to determine damage.
var mght: SaveStat
## Accuracy, used to calculate hitrate when attacking with this weapon.
var acc: SaveStat
## Weight, used to determine how much strength is needed to wield the weapon or conversely, how much it will slow you down.
var wght: SaveStat
## Critical Chance, Used to determine the likelihood of a critical hit.
var crit: SaveStat

# Other
## Current Modifiers on a weapon and its stats
var mods: ModList
## Names of modifiers applied to the wielder, Effects obj.
var effects: Effects
## Char holdign the weapon
var holder:Character


## Exntension of the Item class containign methods and properties relevant to weapons.
func _init(weap_name:String, id:int, type:int, mght:int=0, acc:int=0, uses:int=0, wght:float=0.0, crit:int=0, range:int=1, atck_range:int=1, rq_rnk:int=0, effects:Effects=Effects.new([]), descr:String = ""):
	super(weap_name, id, uses, descr)
	
	self.rq_rnk = rq_rnk
	self.str_rq_rnk = WEAPON_RANK.get(self.rq_rnk)
	self.dmg_type = DMG_TYPE.get(self.id)
	self.atck_range = atck_range
	
	self.mght = SaveStat.new("mght", mght)
	self.acc = SaveStat.new("acc", acc)
	self.wght = SaveStat.new("wght", wght)
	self.crit = SaveStat.new("crit", crit)
	
	self.effects = effects
	holder =  null

# Main

## sets holder to param char. 
func equip(char:Character) -> void:
	holder = char
	self.effects.effect(holder)
	
## Unequips the weapon 
func unequip() -> void:
	holder = null
	

## Returns wether its equipped or not.
func is_equipped() -> bool:
	return holder != null

# Modifiers
## Adds mod to weapon.mods
func add_mod(mod:Modifier) -> void:
	self.mods.add_mod(mod)

## applies all active mods to weapon
func apply_mod(index:int, age:int=1) -> void:
	self.mods.apply_mod(index, age)

## applies all active mods to weapon
func apply(age:int=1) -> void:
	self.mods.apply_mods(age)
	
# Weapon Triangle

## Determines tri-bonus based on its own type and that of the oppossing weapon
func tri_bonus(type:int) -> int:
	return TRI_BONUS[self.type][type]

## Returns the tri-bonus for a given weapon base don its advantage and the rank of its wielder.
func tri_advantages(advatage:bool, char_rnk:int) -> Array[int]:
	if advatage:
		return RANK_ADVANTAGES.get(char_rnk)[0]
	else:
		return RANK_ADVANTAGES.get(char_rnk)[1]

func _str():
	var out:String = self.item_name + ": " + self.descr + "\n\n"
	out += str(self.mght) + "    rq_rnk: " + self.str_rq_rnk + "\n"
	out += str(self.acc) + "    dur: " + str(self.uses) + "\n"
	out += str(self.wght) + "\n"
	out += str(self.crit) + "\n"
	out += str(self.range) + "\n"
	
