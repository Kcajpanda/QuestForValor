##
extends Resource

class_name Character


##
var char_name: String:
	get:
		return char_name
##
var id: int:
	get:
		return id
##
var charclass: CharClass
## The ModManager for a Char and its stats
var mod_manager:ModManager
##
var hp: SaveStat
##
var strn: SaveStat
##
var skl: SaveStat
##
var spd: SaveStat
##
var lck: SaveStat
##
var defn: SaveStat
##
var res: SaveStat
##
var pos: Vector2
##
var weap_rnks: Array

##
func _init(char_name:String, id:int, charclass:CharClass, hp:int, strn:int, skl:int, spd:int, lck:int, defn:int, res:int, weap_rnks:Array):
	self.char_name = char_name
	self.id = id
	self.charclass = charclass
	
	self.hp = SaveStat.new("hp", hp)
	if not self.charclass.is_magic:
		self.strn = SaveStat.new("strn", strn)
	else:
		self.strn = SaveStat.new("mag", strn)
	self.skl = SaveStat.new("skl", skl)
	self.spd = SaveStat.new("spd", spd)
	self.lck = SaveStat.new("lck", lck)
	self.defn = SaveStat.new("defn", defn)
	self.res = SaveStat.new("res", res)
	
	mod_manager = ModManager.new(["hp", self.strn.stat_name, "skl", "spd", "lck", "defn", "res"])
	
	self.weap_rnks = weap_rnks

## function to damage player by given amount
func damage(val) -> void:
	if self.hp.val - val >= 0:
		self.hp.mut(-val)
	else:
		self.hp.set_temp(0)

##	
func weap_rnk(weap_id:int) -> String:
	return self.weap_rnks[weap_id]
	
##
func get_weap_eff(weap_id:int) -> float:
	return charclass.get_weap_eff(weap_id)
	
## 
func is_magic() -> bool:
	return charclass.is_magic
	
##
func is_alive() -> bool:
	return self.hp.val > 0
