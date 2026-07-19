##
extends Resource

class_name InventorySlot

enum slot_size { SMALL, MEDIUM, LARGE, EXTRA_LARGE }

## Reference to item in this slot.
var item:Item
## Size of the slot.
var size:slot_size

##
func _init(size:slot_size=slot_size.SMALL) -> void:
    item = null
    size = size

##
func is_full() -> bool:
    return item != null

##
func place(item:Item) -> void:
    if not self.is_full():
        self.item = item

##
func clear() -> void:
    item = null
