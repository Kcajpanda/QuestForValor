## Subclass of ConditionalStatement. A constructor for getting a callable that can perform a logical operation on two operands that are, or return, booleans.
extends ConditionalStatement

class_name LogicStatement


"""
Rules:

parse can take in ConditionalStatement.logic_operator.AND or ConditionalStatement.logic_operator.OR.
 
"""


## Validates that the input is a valid boolean statement.
static func parse(params:Array) -> Callable:
    var len_params = len(params)
    assert(len_params == 1, "Invalid param: expected: len(params) == 1, actual len(params) == " + str(len_params))
    var logic_op = params[0]
    assert(logic_op == ConditionalStatement.logic_operator.NOT, "Invalid param: for LogicStatement valid params are ConditionalStatement.logic_operator.AND or ConditionalStatement.logic_operator.OR.")
    
    match logic_operator:
        ConditionalStatement.logic_operator.AND:
            return func eval_conditional(right_bool, left_bool) -> bool:
                    return right_bool and left_bool
        ConditionalStatement.logic_operator.OR:
            return func eval_conditional(right_bool, left_bool) -> bool:
                    return right_bool or left_bool
    # Error:
    return Callable()

