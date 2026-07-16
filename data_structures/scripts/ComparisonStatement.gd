## Sub class of Conditional Statement, a constructor takes in an array of logical operator .NOT and comparison operators and returns a func to evaluate params in that set comparison statement.
extends ConditionalStatement

class_name ComparisonStatement


"""
Rules:

    Input array can be for 3 lengths: 1, 2, 3.

    Valid Combinations:
    - length 1:
        - Type 0.0: [compare_operator]
    - length 2:
        - Type 1.1: [logic_operator.NOT, compare_operator]
        - Type 1.2: [compare_operator, logic_operator.NOT]
    - length 3:
        - Type 2.0: [logic_operator.NOT, compare_operator, logic_operator.NOT]

"""


## Validates input array to make sure its of the proper form of a ConditionalStatement.
static func validate(conditional:Array) -> Array: 
    var len_state:int = len(conditional)
    assert(len_state <= 5 and len_state >= 3, "Invalid Params: invalid number of args:" + str(len_state) + "expected 3, 4, or 5 args.")

    var c_operator:ConditionalStatement.compare_operator
    var type_statement:float 

    match len_state:
        1:
            assert(conditional[1] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 1 array[0] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[0])))

            c_operator = conditional[0]
            type_statement = 0.0
        2:
            assert(conditional[0] == ConditionalStatement.logic_operator.NOT or conditional[1] == ConditionalStatement.logic_operator.NOT, "Invalid arg type: for len(Array) = 2 array[0] or array[1] must be of type ConditionalStatement.logic_operator.NOT. Got: typeof(conditional[0])) = " + str(typeof(conditional[0])) + ", typeof(conditional[1]) = " + str(typeof(conditional[1])) )

            if conditional[0] == ConditionalStatement.logic_operator.NOT:
                assert(conditional[1] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 2, where array[0] is NOT, array[1] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[1])))

                c_operator = conditional[1]
                type_statement = 1.1
            else:
                assert(conditional[0] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 2, where array[1] is NOT, array[0] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[0])))

                c_operator = conditional[0]
                type_statement = 1.2
        3:
            assert(conditional[0] == ConditionalStatement.logic_operator.NOT and conditional[2] == ConditionalStatement.logic_operator.NOT, "Invalid arg type: for len(Array) = 3 array[0] and array[2] must be of type ConditionalStatement.logic_operator.NOT. Got: typeof(conditional[0])) = " + str(typeof(conditional[0])) + ", typeof(conditional[2]) = " + str(typeof(conditional[2])) )

            assert(conditional[2] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 3, array[1] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[1])))

            c_operator = conditional[1]
            type_statement = 2.0

    return [c_operator, type_statement]

## Parses validated input and returns a callable.
static func parse(conditional:Array) -> Callable:
    var params := ComparisonStatement.validate(conditional)

    var c_operator:ConditionalStatement.compare_operator = params[0]
    var type_statement:float = params[1]

    match type_statement:
        0.0: 
            match c_operator:
                ConditionalStatement.compare_operator.LESS:
                    return func eval_conditional(right, left) -> bool:
                            return right < left
                ConditionalStatement.compare_operator.LESS_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right <= left
                ConditionalStatement.compare_operator.EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right == left
                ConditionalStatement.compare_operator.GREATER_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right >= left
                ConditionalStatement.compare_operator.GREATER:
                    return func eval_conditional(right, left) -> bool:
                            return right > left
                ConditionalStatement.compare_operator.NOT_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right != left
        1.1:
            match c_operator:
                ConditionalStatement.compare_operator.LESS:
                    return func eval_conditional(right, left) -> bool:
                            return not right < left
                ConditionalStatement.compare_operator.LESS_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right <= left
                ConditionalStatement.compare_operator.EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right == left
                ConditionalStatement.compare_operator.GREATER_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right >= left
                ConditionalStatement.compare_operator.GREATER:
                    return func eval_conditional(right, left) -> bool:
                            return not right > left
                ConditionalStatement.compare_operator.NOT_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right != left
        1.2:
            match c_operator:
                ConditionalStatement.compare_operator.LESS:
                    return func eval_conditional(right, left) -> bool:
                            return right < not left
                ConditionalStatement.compare_operator.LESS_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right <= not left
                ConditionalStatement.compare_operator.EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right == not left
                ConditionalStatement.compare_operator.GREATER_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right >= not left
                ConditionalStatement.compare_operator.GREATER:
                    return func eval_conditional(right, left) -> bool:
                            return right > not left
                ConditionalStatement.compare_operator.NOT_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return right != not left
        2.0:
            match c_operator:
                ConditionalStatement.compare_operator.LESS:
                    return func eval_conditional(right, left) -> bool:
                            return not right < not left
                ConditionalStatement.compare_operator.LESS_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right <= not left
                ConditionalStatement.compare_operator.EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right == not left
                ConditionalStatement.compare_operator.GREATER_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right >= not left
                ConditionalStatement.compare_operator.GREATER:
                    return func eval_conditional(right, left) -> bool:
                            return not right > not left
                ConditionalStatement.compare_operator.NOT_EQUAL:
                    return func eval_conditional(right, left) -> bool:
                            return not right != not left
    # Error:
    return Callable()
