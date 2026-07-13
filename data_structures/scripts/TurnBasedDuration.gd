extends Duration

class_name TurnBasedDuration

## Represents the number of turns it lasts.
var duration:int


##
func _init(duration:int) -> void:
    self.duration = duration

##
func _is_end_end_duration(turn_num):
    pass