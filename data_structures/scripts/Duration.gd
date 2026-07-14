##
extends Resource

class_name IntBasedLife

## The duration of the owning object.
var remaining:int
## Bool for when the duration is down.
var con_is_end:Condition
## Signal for when the duration is down.
signal signal_is_end


func _init(remaining:int) -> void:
    self.remaining = remaining
    is_end = Condition.new()

func dec(val:int=1) -> void:
    remaining -= val
    self._eval_is_end()

func inc(val:int=1) -> void:
    var prev = remaining
    remaining += val
    self._eval_is_end()

##
func _eval_is_end() -> void:
    if remaining <= 0:
        is_end = true
        self.signal_is_end.emit(is_end)
    else:
        is_end = false