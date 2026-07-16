## A state class that serves container representing, a conditional statement. designed for organic pass-through so an items can be entered and this object can then be evaluated to produce the result of the conditional statement it represents.
extends ConditionalStatement

class_name ComplexConditionalStatement

## Wether left should be !left.
var left_is_not:bool
## Wether right should be !right.
var right_is_not:bool
## The type of conditional this instance represents.
var _type_statement:float

"""
Rules:

    Input array can be for 3 lengths: 3, 4, or 5.

    Valid Combinations:
    - length 3:
        - Type 0.0: [Condition, compare_operator, Condition]
    - length 4:
        - Type 1.1: [logical_operator.NOT, Condition, compare_operator, Condition]
        - Type 1.2: [Condition, compare_operator, logical_operator.NOT, Condition]
    - length 5:
        - Type 2.0: [logical_operator.NOT, Condition, compare_operator, logical_operator.NOT, Condition]

"""

##
func _init(conditional:Array, name_signal:Signal=Signal()) -> void:
    super(conditional, name_signal)

## Child override of ConditionalStatement.validate(). Validates input array to make sure its of the proper form of a ComplexConditionalStatement.
func validate(conditional:Array) -> void: 
    var len_state:int = len(conditional)
    assert(len_state <= 5 and len_state >= 3, "Invalid Params: invalid number of args:" + str(len_state) + "expected 3, 4, or 5 args.")
    match len_state:
        3:
            assert(conditional[0] is Condition, "Invalid arg type: for len(Array) = 3 array[0] must be of type Condition. Got: " + str(typeof(conditional[0])))
            assert(conditional[1] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 3 array[1] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[1])))
            assert(conditional[2] is Condition, "Invalid arg type: for len(Array) = 3 array[2] must be of type Condition. Got: " + str(typeof(conditional[2])))

            left = conditional[0]
            c_operator = conditional[1]
            right = conditional[2]
            _type_statement = 0.0
        4:
            assert(conditional[0] == ConditionalStatement.logical_operator.NOT or conditional[2] == ConditionalStatement.logical_operator.NOT, "Invalid arg type: for len(Array) = 4 array[0] or array[2] must be of type ConditionalStatement.logical_operator.NOT. Got: typeof(conditional[0])) = " + str(typeof(conditional[0])) + ", typeof(conditional[2]) = " + str(typeof(conditional[2])) )

            if conditional[0] == logical_operator.NOT:
                assert(conditional[1] is Condition, "Invalid arg type: for len(Array) = 4, where array[0] is NOT, array[1] must be of type Condition. Got: " + str(typeof(conditional[1])))
                assert(conditional[2] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 4, where array[0] is NOT, array[2] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[2])))
                assert(conditional[3] is Condition, "Invalid arg type: for len(Array) = 4, where array[0] is NOT, array[3] must be of type Condition. Got: " + str(typeof(conditional[3])))

                left_is_not = true
                left = conditional[1]
                c_operator = conditional[2]
                right_is_not = false
                right = conditional[3]
                _type_statement = 1.1
            else:
                assert(conditional[0] is Condition, "Invalid arg type: for len(Array) = 4, where array[2] is NOT, array[0] must be of type Condition. Got: " + str(typeof(conditional[0])))
                assert(conditional[1] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 4, where array[2] is NOT, array[1] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[1])))
                assert(conditional[3] is Condition, "Invalid arg type: for len(Array) = 4, where array[2] is NOT, array[3] must be of type Condition. Got: " + str(typeof(conditional[3])))

                left_is_not = false
                left = conditional[0]
                c_operator = conditional[1]
                right_is_not = false
                right = conditional[3]
                _type_statement = 1.2
        5:
            assert(conditional[0] == ConditionalStatement.logical_operator.NOT and conditional[3] == ConditionalStatement.logical_operator.NOT, "Invalid arg type: for len(Array) = 5 array[0] and array[3] must be of type ConditionalStatement.logical_operator.NOT. Got: typeof(conditional[0])) = " + str(typeof(conditional[0])) + ", typeof(conditional[3]) = " + str(typeof(conditional[3])) )

            assert(conditional[1] is Condition, "Invalid arg type: for len(Array) = 5, array[1] must be of type Condition. Got: " + str(typeof(conditional[1])))
            assert(conditional[2] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 5, array[2] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[2])))
            assert(conditional[4] is Condition, "Invalid arg type: for len(Array) = 5, array[4] must be of type Condition. Got: " + str(typeof(conditional[4])))

            left_is_not = true
            left = conditional[1]
            c_operator = conditional[2]
            right_is_not = true
            right = conditional[4]
            _type_statement = 2.0

## Child override of ConditionalStatement.parse(). Parses the validated input that been saved to the instance state and builds a function to return the answer to that conditional statement.
func parse() -> Callable:
    match _type_statement:
        0.0: 
            match c_operator:
                compare_operator.LESS:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() < left.is_con_met()
                compare_operator.LESS_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() <= left.is_con_met()
                compare_operator.EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() == left.is_con_met()
                compare_operator.GREATER_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() >= left.is_con_met()
                compare_operator.GREATER:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() > left.is_con_met()
                compare_operator.NOT_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() != left.is_con_met()
        1.1:
            match c_operator:
                compare_operator.LESS:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() < left.is_con_met()
                compare_operator.LESS_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() <= left.is_con_met()
                compare_operator.EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() == left.is_con_met()
                compare_operator.GREATER_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() >= left.is_con_met()
                compare_operator.GREATER:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() > left.is_con_met()
                compare_operator.NOT_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() != left.is_con_met()
        1.2:
            match c_operator:
                compare_operator.LESS:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() < not left.is_con_met()
                compare_operator.LESS_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() <= not left.is_con_met()
                compare_operator.EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() == not left.is_con_met()
                compare_operator.GREATER_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() >= not left.is_con_met()
                compare_operator.GREATER:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() > not left.is_con_met()
                compare_operator.NOT_EQUAL:
                    return func eval_conditional() -> bool:
                            return right.is_con_met() != not left.is_con_met()
        2.0:
            match c_operator:
                compare_operator.LESS:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() < not left.is_con_met()
                compare_operator.LESS_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() <= not left.is_con_met()
                compare_operator.EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() == not left.is_con_met()
                compare_operator.GREATER_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() >= not left.is_con_met()
                compare_operator.GREATER:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() > not left.is_con_met()
                compare_operator.NOT_EQUAL:
                    return func eval_conditional() -> bool:
                            return not right.is_con_met() != not left.is_con_met()
    # Error:
    return Callable()
