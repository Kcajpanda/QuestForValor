## Ultimate parent class for anything where a condition needs to be met, how or what triggers is_met is determined in the subclasses, as is whether the condition relies on bool or signals to communicate whether the condition has been met. This class is designed to handle either philosophy. Designed to guide class not an instance.
extends Resource

class_name Condition

## Whether the con has been met.
var is_met:bool
## Optional signal that can be used depending on how the subclass chooses bool or signals for its way of detecting wether the condition has been met.
signal signal_is_met_changed
## The signal that carries the event info to be evaluated.
var connected_signal:Signal

## Ultimate parent class for anything where a condition needs to be met, how or what triggers is_met is determined in the subclasses, as is whether the condition relies on bool or signals to communicate whether the condition has been met. This class is designed to handle either philosophy. Designed to guide class not an instance.
func _init(name_signal:Signal=Signal()) -> void:
    is_met = false
    connected_signal = name_signal
    if connected_signal != Signal():
        self.connect_to_check_condition(connected_signal)

## Getter for is_met
func is_con_met() -> bool:
    return is_met 

## Function evaluate to see whether the condition has been met, check_condition() handles the state of .is_met while .evaluate() handles the actual logic of whether the condition has been met.
func check_condition() -> bool: 
    var result = self.evaluate()
    if result != is_met:
        is_met = result
        self.signal_is_met_changed.emit(ConditionIsMetChange.new(is_met, self))

    return is_met

## Does the actual evaluation for whether the condition has been met by evaluating the provided _params. Built to work with bools and signals so wether evaluation is signal triggered or manually triggered and whether the result should, be a bool or a fired signal its handled automatically. Alteration os .is_met state is handles by .check_condition(). Actual logic of this func is implemented by child classes.
func evaluate() -> bool:
    push_warning("Condition.evaluate() not overridden.")
    return false

## Connect the provided signal to eval() so the condition can be signal driven. Only used if signal driven condition is desired.
func connect_to_check_condition(name_signal:Signal) -> void:
    name_signal.connect(check_condition)

## Resets .is_met to true and broadcast that it has been reset.
func reset() -> void:
    is_met = false