## Contains a Condition .condition and the action to do when the condition is met .func_to_exec.
extends Resource

class_name Trigger


## Signal to trigger .func_to_exec.
var condition:Condition
## The func to execute when signaled.
var func_to_exec:Callable


## Contains a condition and the action to do when the con .is_met (func_to_exec).
func _init(condition:Condition, func_to_exec:Callable) -> void:
    self.condition = condition
    self.func_to_exec = func_to_exec

    self._connect(self.condition.signal_is_met, func_to_exec)

## Connects param func to param trigger:Signal. defined as a separate func so connections can be added an altered after _init(). Not sure if ill need it.
func _connect(trigger:Signal, func_to_exec:Callable) -> void:
    trigger.connect(func_to_exec)

## Resets the Condition.
func reset() -> void:
    self.condition.reset()

func _str():
    return str(condition) + " => " + str(func_to_exec)