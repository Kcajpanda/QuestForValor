## Contains a signal (the trigger) and the action to do when triggered (func_to_exec).
extends Resource

class_name Trigger


## Signal to trigger .func_to_exec.
var trigger:Signal
## The func to execute when signaled.
var func_to_exec:Callable


## Contains a signal (the trigger) and the action to do when triggered (func_to_exec).
func _init(trigger:Signal, func_to_exec:Callable) -> void:
    self.trigger = trigger
    self.func_to_exec = func_to_exec

    self._connect()

## Connects the provides func to the trigger signal.
func _connect() -> void:
    self.trigger.connect(self.func_to_exec)

func _str():
    return str(trigger) + " => " + str(func_to_exec)