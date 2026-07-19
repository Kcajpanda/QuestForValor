## Event representing a NumUses obj with .uses_can_dec=true whose .uses=0. Includes .num_uses_obj, a reference to the NumUses obj whose uses just expired.
extends Event

class_name NumUsesEnd

## Item whose uses have ended.
var num_uses_obj:NumUses

## Event representing an items uses expiring, includes .items, a reference to the item whose uses just expired.
func _init(num_uses_obj:NumUses) -> void:
    self.num_uses_obj = num_uses_obj