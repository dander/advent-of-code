Red [
    Title: "Day 3: Spiral Memory"
    Part-1: {
        You come across an experimental new kind of memory stored on an infinite two-dimensional grid.

        Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

        17  16  15  14  13
        18   5   4   3  12
        19   6   1   2  11
        20   7   8   9  10
        21  22  23---> ...
        While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

        For example:

        Data from square 1 is carried 0 steps, since it's at the access port.
        Data from square 12 is carried 3 steps, such as: down, left, left.
        Data from square 23 is carried only 2 steps: up twice.
        Data from square 1024 must be carried 31 steps.
        How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?
    }
]

re: does [do system/options/script]

tests: [1 12 23 1024]

re: does [do system/options/script]

do %../../red/increment.red

input: 347991

get-n: function [i][
    round/ceiling (1 + sqrt i) / 2
]

walk: function [steps][
    step: 1
    pos: 0x0
    decr/by steps step
    n: 1
    act: [[incr/by pos/x n] [incr/by pos/y n incr n] [decr/by pos/x n] [decr/by pos/y n incr n] ]
    while [positive? steps][
        print rejoin ["step: " step ", pos: " pos]
        n: min n steps
        incr/by step n
        decr/by steps n
        if tail? act [act: head act]
        do first act
        act: next act
    ]
    pos
]

part-1: function [steps][
    pos: walk steps
    abs: absolute pos
    print rejoin [steps ": " pos ", result: " abs/x + abs/y]
]

foreach test tests [
    part-1 test
]

part-1 input
