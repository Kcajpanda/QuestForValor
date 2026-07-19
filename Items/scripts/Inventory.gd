## Wrapper of an Array that stores only items and allows for common inventory funcs.
extends Resource

class_name Inventory

## Size of the inventory.
var inven_size:int
## Array that holds items.
var inventory:Array[Item]

## Wrapper of an Array that stores only items and allows for common inventory funcs.
func _init(inven_size:int=5) -> void:
    self.inven_size = inven_size
    inventory = []

    for i in range(self.inven_size):
        inventory.append(null)

## Returns Item at param index.
func get_item(index:int) -> Item:
    self.in_range(index)
    return inventory[index]

## Places Item at param index.
func place(index:int, item:Item) -> void:
    self.in_range(index)
    if is_spot_empty(index):
        inventory[index] = item

## Adds Item to earliest open spot in .inventory.
func add(item:Item) -> void:
    for i in range(inven_size):
        if is_spot_empty(i):
            inventory[i] = item

## Returns item at param index, and clear that index in .inventory.
func take(index:int) -> Item:
    self.in_range(index)
    var item:Item = inventory[index]
    clear_spot(index)
    return item

## Swaps the Items at param index_1 and param index_2, even if they are empty.
func swap(index_1:int, index_2:int) -> void:
    in_range(index_1)
    in_range(index_2)
    var temp:Item = get_item(index_1)
    place(index_1, get_item(index_2))
    place(index_2, temp)

## Swaps items at self.inventory[index_1] and param inventory_2[index_2]
func swap_between(index_1, inventory_2:Inventory, index_2) -> void:
    self.in_range(index_1)
    inventory_2.in_range(index_2)
    var temp:Item = self.get_item(index_1)
    self.place(index_1, inventory_2.get_item(index_2))
    inventory_2.place(index_2, temp)

##
func equip(index) -> void:
    swap(0, index)

## Sets inventory[index] to null.
func clear_spot(index:int) -> void:
    self.in_range(index)
    inventory[index] = null

## Returns whether inventory[index] == null, menaing its empty of an Item.
func is_spot_empty(index:int) -> bool:
    self.in_range(index)
    return inventory[index] == null

## Returns whether the .inventory is full. 
func is_inventory_full() -> bool:
    for i in range(inven_size):
        if is_spot_empty(i):
            return false
    return true

## Asserts that the passed index must be in range of available .inventory indexes, or specifically in the range range(inven_len).
func in_range(index:int) -> void:
    assert(index in range(inven_size), "Invalid param: index must be in range(.inven_size)")

func _str():
    var out:String = "Inventory:" + "\n"
    for item in inventory:
        out += "  - " + str(item) + "\n"
    return out