Red [
    Title: "Advent of code day 1 problem 1"
    Page: http://adventofcode.com/2016/day/1
    Description: {
        --- Day 1: No Time for a Taxicab ---

        Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

        Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

        You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and nobody had time to work them out further.

        The Document indicates that you should start at the given coordinates (where you just landed) and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given number of blocks, ending at a new intersection.

        There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the destination?

        For example:

        Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
        R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
        R5, L5, R5, R3 leaves you 12 blocks away.
        How many blocks away is Easter Bunny HQ?
    }
    Part-Two: {
        Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually at the first location you visit twice.

        For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East.

        How many blocks away is the first location you visit twice?
    }
]

input: "R1, L4, L5, L5, R2, R2, L1, L1, R2, L3, R4, R3, R2, L4, L2, R5, L1, R5, L5, L2, L3, L1, R1, R4, R5, L3, R2, L4, L5, R1, R2, L3, R3, L3, L1, L2, R5, R4, R5, L5, R1, L190, L3, L3, R3, R4, R47, L3, R5, R79, R5, R3, R1, L4, L3, L2, R194, L2, R1, L2, L2, R4, L5, L5, R1, R1, L1, L3, L2, R5, L3, L3, R4, R1, R5, L4, R3, R1, L1, L2, R4, R1, L2, R4, R4, L5, R3, L5, L3, R1, R1, L3, L1, L1, L3, L4, L1, L2, R1, L5, L3, R2, L5, L3, R5, R3, L4, L2, R2, R4, R4, L4, R5, L1, L3, R3, R4, R4, L5, R4, R2, L3, R4, R2, R1, R2, L4, L2, R2, L5, L5, L3, R5, L5, L1, R4, L1, R1, L1, R4, L5, L3, R4, R1, L3, R4, R1, L3, L1, R1, R2, L4, L2, R1, L5, L4, L5"

vect: function [a b][object [x: a y: b]]

rotate: function [pair [pair! object!] angle [number!]][
    vect 
        (pair/x * cosine angle) - (pair/y * sine angle)
        (pair/x * sine angle) + (pair/y * cosine angle)
]

direction: vect 1.0 0.0

pos: vect 0.0 0.0

digits: charset "1234567890"

turn: ["R" (direction: rotate direction 90) | "L" (direction: rotate direction -90)]

rules: [
    some [
        turn
        copy dist some digits (
                dist: load dist
                pos/x: pos/x + (dist * direction/x)
                pos/y: pos/y + (dist * direction/y)
                )
        | skip
    ]
]

test1: [
    input: "R2, L3"
    output: 5
]

test2: [
    input: "R2, R2, R2"
    output: 2
]

test3: [
    input: "R5, L5, R5, R3"
    output: 12
]

foreach test reduce [test1 test2 test3 compose [input: (input) output: "???"]][
    direction: vect 0.0 1.0
    pos: vect 0.0 0.0
    do [parse test/input rules]
    print [(absolute pos/x) + (absolute pos/y) "should be" test/output]
]

