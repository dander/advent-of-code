Red [
    Title: "Day 4: Security Through Obscurity"
    Needs: 'View
    Part-1: {
        Finally, you come across an information kiosk with a list of rooms. Of course, the list is encrypted and full of decoy data, but the instructions to decode the list are barely hidden nearby. Better remove the decoy data first.

        Each room consists of an encrypted name (lowercase letters separated by dashes) followed by a dash, a sector ID, and a checksum in square brackets.

        A room is real (not a decoy) if the checksum is the five most common letters in the encrypted name, in order, with ties broken by alphabetization. For example:

        aaaaa-bbb-z-y-x-123[abxyz] is a real room because the most common letters are a (5), b (3), and then a tie between x, y, and z, which are listed alphabetically.
        a-b-c-d-e-f-g-h-987[abcde] is a real room because although the letters are all tied (1 of each), the first five are listed alphabetically.
        not-a-real-room-404[oarel] is a real room.
        totally-real-room-200[decoy] is not.
        Of the real rooms from the list above, the sum of their sector IDs is 1514.

        What is the sum of the sector IDs of the real rooms?
    }
    Part-2: {
        With all the decoy data out of the way, it's time to decrypt this list and get moving.

        The room names are encrypted by a state-of-the-art shift cipher, which is nearly unbreakable without the right software. However, the information kiosk designers at Easter Bunny HQ were not expecting to deal with a master cryptographer like yourself.

        To decrypt a room name, rotate each letter forward through the alphabet a number of times equal to the room's sector ID. A becomes B, B becomes C, Z becomes A, and so on. Dashes become spaces.

        For example, the real name for qzmt-zixmtkozy-ivhz-343 is very encrypted name.

        What is the sector ID of the room where North Pole objects are stored?
    }
]

test: [
    "aaaaa-bbb-z-y-x-123[abxyz]"
    "a-b-c-d-e-f-g-h-987[abcde]"
    "not-a-real-room-404[oarel]"
    "totally-real-room-200[decoy]"
]

alpha: charset [#"a" - #"z"]

digit: charset [#"0" - #"9"]

decompose: function [str][
    parts: parse str [
        collect [
            keep some [alpha | #"-" ahead alpha]
            #"-"
            keep some digit
            #"[" keep some alpha #"]"
        ]
    ]
    make map! reduce ['name parts/1 'sector load parts/2 'checksum parts/3]
]

get-checksum: function [name][
    ; count occurrances
    cs: copy []
    foreach i name [
        either find cs i [
            cs/:i: cs/:i + 1
        ][
            if find alpha i [repend cs [i 1]]
        ]
    ]
    ; sort by occurrances, decending by count, then alphabetically
    sort/skip/compare/all cs 2 func [a b][ reduce [a b] either a/2 = b/2 [a/1 < b/1] [a/2 > b/2]]
    ; join back to string
    take/part rejoin collect [foreach [i j] cs [keep i]] 5
]

valid-room?: function [room][
    room/checksum = get-checksum room/name 
]

; rooms: test
rooms: read/lines %day4-input.txt

where: function [block pred][
    collect [
        foreach i block [if pred i [keep i]]
    ]
]

apply: function [block funct][
    collect [
        foreach i block [keep funct i]
    ]
]

rooms: apply rooms :decompose

valid: where rooms :valid-room?

print rejoin ["Out of " length? rooms ", " length? valid " are valid"]

sum: 0
foreach room valid [
    sum: sum + room/sector
]

print ["sector sum:" sum]

decode-room: func [room][
    rejoin collect [foreach i room/name [
        keep either i = #"-" [#" "][
            i - #"a" + room/sector % 26 + #"a"
        ]
    ]]
]

apply valid func [room][probe reduce [room/sector decode-room room]]
