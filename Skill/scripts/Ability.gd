## A Skill with a condtition before it can be activated
extends Skill

class_name ConSkill

##
var condition

##
func _init(abl_name, id, condition, descr:String):
	super(abl_name, id, descr)
	self.condition = condition
