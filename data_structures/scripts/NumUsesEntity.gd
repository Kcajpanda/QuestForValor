## Like an entity but with set a number of times it can be used, and func age() that can decrease its .uses and returns true when its time for deletion of the instance.
extends Entity

class_name NumUsesEntity

## NumUses obj managing uses.
var uses:NumUses

## Same Param as Entity but takes in a uses:int for .uses
func _init(name:String, id, uses:int, descr:String="") -> void:
	super(name, id, descr)
	self.uses = NumUses.new(uses)

## runs .uses.dec_uses(value).
func dec_uses(value:int=1) -> void:
	uses.dec_uses(value)
		
## returns relevant info before descr so to remove repeat code in child _str().
func _str_helper() -> String:
	return super() + str(uses) + ", "

## returns "en_name: id | {id}, uses: {uses}, descr".
func _str():
	return self._str_helper() + descr
