## Child of ConditionalStatement designed to handle simple non conditional right and left sides. Left and right sides can be objects, callables or primitives but cannot be or return conditional statements, but cna be booleans. For a Conditional Statement that can handle left and right side conditionals see ComplexConditionalStatement.
extends ConditionalStatement

class_name SimpleConditionalStatement

## Whether left is a callable.
var is_left_callable:bool
## Whether right is a callable.
var is_right_callable:bool

## Child of ConditionalStatement designed to handle simple non conditional right and left sides. Left and right sides can be objects, callables or primitives but cannot be or return conditional statements, but cna be booleans. For a Conditional Statement that can handle left and right side conditionals see ComplexConditionalStatement.
func _init(conditional:Array, name_signal:Signal=Signal()) -> void:
    super(conditional, name_signal)

## Child override of ConditionalStatement.validate().Validates input array to make sure its of the proper form for a SimpleConditionalStatement.
func validate(conditional:Array) -> void:
    var len_state:int = len(conditional)
    assert(len_state == 3, "Invalid Params: invalid number of args:" + str(len_state) + "expected 3.")

    assert(conditional[1] is ConditionalStatement.compare_operator, "Invalid arg type: for len(Array) = 3 array[1] must be of type ConditionalStatement.compare_operator. Got: " + str(typeof(conditional[1])))

    if left is Callable:
        is_left_callable = true
    if right is Callable:
        is_right_callable = true

    left = conditional[0]
    c_operator = conditional[1]
    right = conditional[2]

## Child override of ConditionalStatement.parse(). Parses the validated input that been saved to the instance state and builds a function to return the answer to that conditional statement.
func parse() -> Callable:
    if is_left_callable and is_right_callable:
        match c_operator:
            compare_operator.LESS:
                return func eval_conditional() -> bool:
                        return right.call() < left.call()
            compare_operator.LESS_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() <= left.call()
            compare_operator.EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() == left.call()
            compare_operator.GREATER:
                return func eval_conditional() -> bool:
                        return right.call() > left.call()
            compare_operator.GREATER_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() >= left.call()
            compare_operator.NOT_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() != left.call()
    elif is_left_callable:
        match c_operator:
            compare_operator.LESS:
                return func eval_conditional() -> bool:
                        return right < left.call()
            compare_operator.LESS_EQUAL:
                return func eval_conditional() -> bool:
                        return right <= left.call()
            compare_operator.EQUAL:
                return func eval_conditional() -> bool:
                        return right == left.call()
            compare_operator.GREATER:
                return func eval_conditional() -> bool:
                        return right > left.call()
            compare_operator.GREATER_EQUAL:
                return func eval_conditional() -> bool:
                        return right >= left.call()
            compare_operator.NOT_EQUAL:
                return func eval_conditional() -> bool:
                        return right != left.call()
    elif is_right_callable:
        match c_operator:
            compare_operator.LESS:
                return func eval_conditional() -> bool:
                        return right.call() < left
            compare_operator.LESS_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() <= left
            compare_operator.EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() == left
            compare_operator.GREATER:
                return func eval_conditional() -> bool:
                        return right.call() > left
            compare_operator.GREATER_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() >= left
            compare_operator.NOT_EQUAL:
                return func eval_conditional() -> bool:
                        return right.call() != left
    else:
        match c_operator:
            compare_operator.LESS:
                return func eval_conditional() -> bool:
                        return right < left
            compare_operator.LESS_EQUAL:
                return func eval_conditional() -> bool:
                        return right <= left
            compare_operator.EQUAL:
                return func eval_conditional() -> bool:
                        return right == left
            compare_operator.GREATER:
                return func eval_conditional() -> bool:
                        return right > left
            compare_operator.GREATER_EQUAL:
                return func eval_conditional() -> bool:
                        return right >= left
            compare_operator.NOT_EQUAL:
                return func eval_conditional() -> bool:
                        return right != left
    
    return Callable()
    