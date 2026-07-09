##
extends Entity

class_name Skill

##
var skl_rnk

##
func _init(skl_name:String, id, skl_rnk, descr:String="") -> void:
	super(skl_name, id, descr)
	self.skl_rnk = skl_rnk
	
## Uses the Skill.
func use():
	pass
	

	
