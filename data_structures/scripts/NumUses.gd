## Simple object that tracks the numbers of uses an object has at time of instantiation and has remaining. .uses can be decreased with .age() and .age() will return a bool of wether it has run out of uses. If uses=-1 the object's .uses_can_dec is then set false so the object cannot ever run out of uses.
extends Resource

class_name NumUses

## Uses, or age, how many uses it has.
var uses:int
## Total uses, static val of whatever uses is instantiated as.
var total_uses:int
## Whether the entity can be aged.
var uses_can_dec:bool

## Simple object that tracks the numbers of uses an object has at time of instantiation and has remaining. .uses can be decreased with .age() and .age() will return a bool of wether it has run out of uses. If uses=-1 the object's .uses_can_dec is then set false so the object cannot ever run out of uses.
func _init(uses:int=-1) -> void:
	self.uses = uses
	total_uses = uses
	if self.uses == -1:
		uses_can_dec = false
	else:
		uses_can_dec = true

## Decrease .uses by value, then emits a NumUsesChanged event, and finally returns a bool of whether its time for it to be deleted. 
func dec_uses(value:int=1) -> bool:
	var prev_uses:int = uses
	if uses_can_dec:
		uses -= value
	UsesBus.uses_chnaged.emit(NumUsesChanged.new(self, prev_uses))
	return check_end_uses()

## Checks whether the NumUses has reached the end opf its .uses, returns true or false. If true emits emits NumUsesEnd event. 
func check_end_uses() -> bool:
	if uses_can_dec and uses <= 0:
		UsesBus.end_uses.emit(NumUsesEnd.new(self))
		return true
	return false

## returns "uses: {.uses}"
func _str():
	if uses_can_dec:
		return "uses: " + str(uses)
	else:
		return "uses: - - -"
