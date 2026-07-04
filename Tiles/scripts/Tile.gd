## Relevent Properties for a QoV tile, and includes functionality for stat boosts, weather, and other modifiers and effects to change the tile's stats and appearance.
extends Entity

class_name Tile

var ID = {
	0: "base",
	1: "plains",
	2: "mountains"
}

# Immutables
## tile X, Internal class position tracking for attack checks.
var x_pos: int
## tile Y, Internal class position tracking for attack checks.
var y_pos: int
## Elevation the tile is considered at.
var height: int

#Mutables
## Defense, defense boost granted by being on that tile.
var defn: SaveStat
### Accuracy, accuracy boost granted by being on that tile.
#var acc: SaveStat
## Dodge, dodge boost granted by being on that tile.
var dge: SaveStat
## Movement Cost, the required cost to move off that tile.
var mv_cost: SaveStat

## Relevent Properties for a QoV tile, and includes functionality for stat boosts, weather, and other modifiers and effects to change the tile's stats and appearance.
func _init(tile_name:String, id:int, height:int, x_pos:int, y_pos:int, descr:String, defn:int, dge:int, mv_cost:int) -> void:
	super(tile_name, id, descr)
	
	self.x_pos = x_pos
	self.y_pos = y_pos
	self.height = height
	
	self.defn = SaveStat.new("defn", defn)
	#self.acc = SaveStat.new("acc", acc)
	self.dge = SaveStat.new("dge", dge)
	self.mv_cost = SaveStat.new("mv_cost", mv_cost)

## Resets all Tile stats to perm_vals
func reset() -> void:
	self.defn.reset()
	#self.acc.reset()
	self.dge.reset()
	self.mv_cost.reset()

##
func _str():
	var out:String = en_name + ": id | " + str(id) + ", "
	out += ""
	return out
	
