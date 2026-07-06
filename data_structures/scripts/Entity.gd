## Ultimate parent class for any obj with an anme and id
extends Resource

class_name Entity

## name of the entity
var en_name:String
## Identifiable id for the entity that can be matched up to dictionary to easily identify its traits
var id
## (Optional) Description of the entity
var descr:String

##
func _init(en_name:String, id, descr:String) -> void:
	self.en_name = en_name
	self.id = id
	self.descr = descr
	
## returns relevent info before descr so to remove repeat code in child _str()
func _str_helper() -> String:
	return en_name + ": id | " + str(id) + ", "

## returns "en_name: id | {val}, descr"
func _str():
	return en_name + ": id | " + str(id) + ", " + self.descr
