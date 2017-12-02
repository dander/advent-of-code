Red [
    Title: "day 3"
    Part-1: {
        --- Day 3: Squares With Three Sides ---

        Now that you can think clearly, you move deeper into the labyrinth of hallways and office furniture that makes up this part of Easter Bunny HQ. This must be a graphic design department; the walls are covered in specifications for triangles.

        Or are they?

        The design document gives the side lengths of each triangle it describes, but... 5 10 25? Some of these aren't triangles. You can't help but mark the impossible ones.

        In a valid triangle, the sum of any two sides must be larger than the remaining side. For example, the "triangle" given above is impossible, because 5 + 10 is not larger than 25.

        In your puzzle input, how many of the listed triangles are possible?
    }
    Part-2: {
        Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.
  
        For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:
  
        101 301 501
        102 302 502
        103 303 503
        201 401 601
        202 402 602
        203 403 603
  
        In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?
    }
]

input: read %day-3-input.txt

test: {
  383  573  458
  111  337  947
  381  366  568
  883  323  560
  942  136  297
  103  324  576
}

sum: function [block][
    t: 0
    foreach i block [t: t + i]
    t
]

max-series: function [series][
    m: first series
    foreach i series [
        m: max m i
    ]
    m
]

valid-triangle?: function [block][
    m: max-series block
    m < ((sum block) - m)
]

blocks: parse load input [collect [any [keep 3 number!]]]

count: 0

foreach b blocks [
    if valid-triangle? b [count: count + 1]
]

print rejoin ["answer1: " count]

blocks: collect [
  i: 0
  foreach [a b c] blocks [
    loop 3 [
      i: i // 3 + 1
      keep/only reduce [a/:i b/:i c/:i]
    ]
  ]
]

count: 0

foreach b blocks [
    if valid-triangle? b [count: count + 1]
]

print rejoin ["answer1: " count]