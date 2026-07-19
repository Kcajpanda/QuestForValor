## Attack.gd event showing the result of an attack. It contains pre_hp:int, post_hp:int, result:Attack.state.
extends Event

class_name AttackResult

## Pre hp.
var pre_hp:int
## Post hp.
var post_hp:int
## Attack State
var result:Attack.state

## Attack.gd event showing the result of an attack. It contains pre_hp:int, post_hp:int, result:Attack.state.
func _init(pre_hp:int, post_hp:int, result:Attack.state) -> void:
    self.pre_hp = pre_hp
    self.post_hp = post_hp
    self.result = result