## The Same as a Trigger, only unique in its class name since this is such a common trigger.
extends Trigger

class_name DeathTrigger

## The Same as a Trigger, only unique in its class name since this is such a common trigger.
func _init(trigger:Signal, func_to_exec:Callable) -> void:
    super(trigger, func_to_exec)