## Like an entity but with set a number of times it can be used, and func age() that can decrease its .uses and returns true when its time for deletion of the instance.
extends Entity

class_name AgeEntity

## Uses, or age, how many uses it has
var uses: int
## Total uses, static val of whatever uses is instansiated as.
var total_uses: int
## Wether the entity can be aged.
var ageable:bool

## Same Param as Entity but takes in a uses:int for .uses
func _init(name:String, id, uses:int, descr:String="") -> void:
	super(name, id, descr)
	self.uses = uses
	self.total_uses = uses
	if self.uses == -1:
		self.ageable = false
	else:
		self.ageable = true

## Decrease the uses by value, then returns a bool of whether its time for it to be deleted. 
func age(value:int=1) -> bool:
	if ageable:
		self.dur -= value
		if self.dur <= 0:
			self.dur = 0
			return true
		else:
			return false
	else:
		return false
		
## returns relevent info before descr so to remove repeat code in child _str()
func _str_helper() -> String:
	return super() + " uses: " + str(uses) + ","

## returns "en_name: id | {id}, uses: {uses}, descr"
func _str():
	return self._str_helper() + " " + descr
