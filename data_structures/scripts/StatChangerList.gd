##
extends Resource

class_name StatChangerList

## list of Dictionary of modifiers sorted by id (allows for duplicates of modifier with easy distinction between them regardless of the removal of other entries.)
var stat_changers: Dictionary[int, StatChanger]
## start id number.
var start_id: int
## id of next entry to be added.
var curr_id: int

##
func _init(start_id:int=0) -> void:
    stat_changers = {}
    self.start_id = start_id
    curr_id = start_id

## Runs .operate(value) on the StatChanger at param key:int.
func operate(key:int, value):
    return stat_changers[key].operate(value)

## Adds StatChanger of type param stat_changer_type:Variant .stat_changers.
func add(stat_chnager_type:Variant, name:StringName) -> void:
    stat_changers[curr_id] = stat_chnager_type.new(name, curr_id)
    _increment_id()

## Removes StatChanger at param key:int.
func remove(key:int) -> void:
    stat_changers.erase(key)

## Increases id by 1.
func _increment_id() -> void:
    curr_id += 1

func _str():
    var out:String = "StatChangers:" + "\n"
    for stat_changer in stat_changers:
        out += "  - " + str(stat_changer) + ":\n"
    return out
