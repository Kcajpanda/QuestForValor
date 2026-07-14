## Event representing that a given val has changed, contains its prev_val and its new_val.
extends AnnounceEvent

class_name ValChanged

## Prev magnitude of the val
var prev
## Curr magnitude of the val
var curr

## Event representing that a given val has changed, contains its prev_val and its new_val.
func _init(prev, curr) -> void:
    self.prev = prev
    self.curr = curr