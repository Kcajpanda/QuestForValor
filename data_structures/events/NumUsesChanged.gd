## Event representing when the .uses in a NumUses obj changes. Contains .uses_obj, a reference to said NumUses obj, and .prev_uses:int representing the previous val of uses_obj.uses.
extends Event

class_name NumUsesChanged

## The NumUses obj that changed its .uses
var uses_obj:NumUses
## prev val of .uses
var prev_uses:int

## Event representing when the .uses in a NumUses obj changes. Contains .uses_obj, a reference to said NumUses obj, and .prev_uses:int representing the previous val of uses_obj.uses.
func _init(uses_obj:NumUses, prev_uses:int) -> void:
    self.uses_obj = uses_obj
    self.prev_uses = prev_uses