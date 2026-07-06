## Relevent Properties for a QoV tile, and includes functionality for stat boosts, weather, and other modifiers and effects to change the tile's stats and appearance.
extends Entity

class_name Tile

const ID = { # rq_terr_skl, defn, dge, [mv_cost, profeciency_mv_cost] 
	"plains": [ 0, 0, 0, [1,1] ],
	"plain_hills": [ 1, 0, 0, [1,1] ],
	"thick_sand": [ 0, 0, 0, [2,1] ],
	"wall": [ 5, 0, 0, [0,0] ],
}

const TERRAIN_SKILL = [
	0, #Any
	1,
	2,
	3,
	4,
	5 #Impassable
]

# Immutables
## tile X, Internal class position tracking for attack checks.
var pos: Vector2
## Elevation the tile is considered at.
var height: int
## Required terrain Skill to pass over
var rq_terr_skl: int
## Whether anything cna pass over or a through said tile
var is_passable: bool

#Mutables
## Defense, defense boost granted by being on that tile.
var defn: SaveStat
### Accuracy, accuracy boost granted by being on that tile.
#var acc: SaveStat
## Dodge, dodge boost granted by being on that tile.
var dge: SaveStat
## Movement Cost, the required cost to move off that tile.
var mv_cost: SaveStat
## Profeciency Movement Coct, movement cost for when the traveler is skille donm this terrain.
var prof_mv_cost: SaveStat

## Relevent Properties for a QoV tile, and includes functionality for stat boosts, weather, and other modifiers and effects to change the tile's stats and appearance.
func _init(tile_name:String, id:String, height:int, pos:Vector2, descr:String="") -> void:
	super(tile_name, id, descr)
	
	self.height = height
	self.pos = pos
	
	var stats = ID.get(id)
	
	rq_terr_skl = stats[0]
	is_passable = self._det_passability(self.rq_terr_skl)
	defn = SaveStat.new("defn", stats[1])
	dge = SaveStat.new("dge", stats[2])
	mv_cost = SaveStat.new("mv_cost", stats[3][0])
	prof_mv_cost = SaveStat.new("mv_cost", stats[3][1])

## Resets all Tile stats to perm_vals
func reset() -> void:
	self.defn.reset()
	self.dge.reset()
	self.mv_cost.reset()
	
##
func can_pass(obj1:Object) -> bool:
	if is_passable:
		obj1

## Returns the distance between two positions returned as an int
func distance(pos1:Vector2, pos2:Vector2) -> int:
	return int(sqrt( pow((pos1[0] - pos2[0]), 2) + pow((pos1[1] - pos2[1]), 2) ))
	
## Returns wether a given obj is in range of anothe obj 
func in_range(range:int, obj1:Object, obj2:Object) -> bool:
	return self.distance(obj1.pos, obj2.pos) == range

##
func _det_passability(param_rq_terr_skl:int) -> bool:
	return param_rq_terr_skl != 5

func _str():
	var out:String = en_name + ": id | " + str(id) + ", "
	out += ""
	return out
	
