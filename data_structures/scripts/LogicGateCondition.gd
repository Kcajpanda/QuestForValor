## Like a MultiCondition but only contains two conditions and functions as a logic gate but uses either bool or signal type connection.
extends Condition

class_name LogicGateCondition

enum CONDITIONAL { AND, OR, NOT }

"""
Rules:

Ex {NOT: cond1}, AND, con2

Param con1 and con2 must be either dictionaries of length 1 or Conditions. if they are dictionaries the key must be CONDITIONAL.NOT and the value must be a Condition. conditional must be either CONDITIONAL.AND or CONDITIONAL.OR.
 
"""

## The first Condition.
var con1:Condition
## Whether con1 is evaluated as NOT con1.
var is_con1_not:bool
## The conditional used.
var conditional:CONDITIONAL
## The second Condition.
var con2:Condition
## Whether con2 is evaluated as NOT con1.
var is_con2_not:bool

## Like a MultiCondition but only contains two conditions and functions as a logic gate but uses either bool or signal type connection.
func _init(con1, conditional:CONDITIONAL, con2,name_signal:Signal=Signal()) -> void:
    self.validate(con1, conditional, con2)
    super(name_signal)

    self.connect_to_check_condition(self.con1.signal_is_met_changed)
    self.connect_to_check_condition(self.con2.signal_is_met_changed)

## Validates that the input is a valid boolean statement.
func validate(con1, conditional:CONDITIONAL, con2) -> void:
    # Con1
    if con1 is Dictionary:
        self.validate_dict(con1)
        self.con1 = con1[CONDITIONAL.NOT]
        is_con1_not = true
    else:
         assert(con1 is Condition, "Invalid param: con1 must be of type Condition or its subclasses")
         self.con1 = con1 
    
    # Con2
    if con2 is Dictionary:
        self.validate_dict(con2)
        self.con2 = con2[CONDITIONAL.NOT]
        is_con2_not = true
    else:
         assert(con2 is Condition, "Invalid param: con1 must be of type Condition or its subclasses")
         self.con2 = con2
    
    assert(conditional != CONDITIONAL.NOT, "Invalid param: conditional must be either CONDITIONAL.AND or CONDITIONAL.OR.")
    self.conditional = conditional

## Validates that if a param is a Dictionary that it matches the rules of the class.
func validate_dict(dict:Dictionary) -> void:
    assert(dict.size() == 1, "Invalid param: Dictionary must be length of 1.")
    var key = dict.keys()[0]
    assert(key == CONDITIONAL.NOT, "Invalid Param: If dictionary is used the key must be CONDITIONAL.NOT.")
    assert(dict[key] is Condition, "Invalid param: value in dictionary must be a Condition.")

## Resolves the conditional. Returns upward to eval().
func evaluate() -> bool:
    var con1_result:bool = con1.is_con_met()
    var con2_result:bool = con2.is_con_met()

    if is_con1_not:
        con1_result = !con1_result
    if is_con2_not:
        con2_result = !con2_result

    if conditional == CONDITIONAL.AND:
        return con1_result and con2_result
    else:
        return con1_result or con2_result
