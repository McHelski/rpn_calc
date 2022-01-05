#!/bin/julia

manual = 
"""

 ____  ____  _   _    ____      _      
|  _ \\|  _ \\| \\ | |  / ___|__ _| | ___ 
| |_) | |_) |  \\| | | |   / _` | |/ __|
|  _ <|  __/| |\\  | | |__| (_| | | (__ 
|_| \\_\\_|   |_| \\_|  \\____\\__,_|_|\\___|


HOW TO USE
~~~~~~~~~~

1. Type the name of this program followed by an RPN expression enclosed in double quotes.
2. Press <Enter>.
3. Numerical value of that expression will be printed to the console.


SYNTAX RULES
~~~~~~~~~~~~

- The input expression may contain any floating-point numbers in base-10 (0, 1.0, -3.14, 69, etc.).
- All tokens (numbers and operators) must be separated with single spaces.
- The only allowed operators are:
    - '+' (addition)
    - '-' (subtraction)
    - '*' (multiplication)
    - '/' (division)
    - '%' (remainder division)
    - '^' (exponentiation)
- The input expression may containt only numbers, operators and spaces.
- The input expression must represent a valid arithmetic expression accordingly to RPN rules.
- The entire expression must be enclosed in double quotes.


EXAMPLE
~~~~~~

INPUT: "12 2 3 4 * 10 5 / + * +"
OUTPUT: 40.0

"""

function calc_rpn(my_expr::String)
    num_op_arr = split(my_expr, " ")
    my_stack = Float64[]

    for i ∈ num_op_arr
        if i ∈ ["+", "-", "*", "/", "%", "^"]
            a = pop!(my_stack)
            b = pop!(my_stack)
            push!(my_stack, eval(Expr(:call, Meta.parse(i), b, a)))
        else
            push!(my_stack, parse(Float64, i))
        end
    end

    return pop!(my_stack)
end

function main(args)
    if length(args) == 0 || lowercase(args[begin]) ∈ ("?", "h", "help")
        print(manual)
    else
        try
            my_expr = args[begin]
            println(calc_rpn(my_expr))
        catch
            println("ERROR: Invalid arguments.")
        end
    end
end

main(ARGS)
