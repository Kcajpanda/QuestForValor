## Like a Trigger, but instead of executing a function it changes the value of a bool recording wether the signal has been flipped to true. Has a way to reset the bool if needed.
extends Condition

class_name SignalLatch

## The signal the trigger listens for
var trigger:Signal
## Signal representing that triggered was switched
signal signal_con_was_met

## Like a Trigger, but instead of executing a function it changed the value of a bool recording wether the signal has been flipped to true. Has a way to reset the bool if needed. 
func _init(trigger:Signal) -> void:
    super()
    self.trigger = trigger
    self._connect()

## Connects trigger to _triggered().
func _connect() -> void:
    trigger.connect(_triggered)

## Returns .triggered().
func _triggered() -> void:
    self.con_was_met()
    self.signal_con_was_met.emit()
