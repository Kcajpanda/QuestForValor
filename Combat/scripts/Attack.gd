##
extends Resource

class_name Attack
##
enum State {NONE=0, MISS=1, DODGE=2, HIT=3, CRIT=4}
##
var rng

##
var char1: Character
##
var weap1:Weapon
##
var char2:Character
##
var weap2: Weapon
##
var tile2:Tile
##
var crit:int
##
var hit:int
##
var dge:int
##
var miss:int
##
var dmg:int
##
var pre_hp:int
##
var post_hp:int
##
var result:State:
	get:
		return result
##
var data:Array:
	get:
		return data

##
func _init(char1:Character, weap1:Weapon, char2:Character, weap2:Weapon, tile2:Tile, stats:Array[int]):
	rng = RandomNumberGenerator.new()
	self.char1 = char1
	self.weap1 = weap1
	self.char2 = char2
	self.weap2 = weap2
	self.tile2 = tile2
	crit = stats[0]
	hit = stats[1]
	dge = stats[2]
	dmg = stats[3]
	miss = 100 - hit
	pre_hp = char2.hp.val
	
	data = [char1, weap1, char2, weap2, tile2, crit, hit, dge, miss, dmg, pre_hp]

## Wrapper for random number from [1,100]
func _roll_die() -> int:
	return rng.randi_range(1,100)

##
func roll() -> State:
	var rolled := self._roll_die()
	if rolled > hit:
		result = State.MISS
		post_hp = pre_hp
	elif rolled <= hit and rolled > dge:
		result = State.DODGE
		post_hp = pre_hp
	elif rolled <= dge and rolled > crit:
		result = State.HIT
		post_hp = pre_hp - dmg
		self.weap1.age()
	elif rolled <= crit:
		result = State.CRIT
		post_hp = pre_hp - (dmg*3)
		self.weap1.age()
	else:
		result = State.MISS
	data += [post_hp, result]
	return result
