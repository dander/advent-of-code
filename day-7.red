Red [
    Title: "Day 7: Internet Protocol Version 7"
    Part-1: {
        While snooping around the local network of EBHQ, you compile a list of IP addresses (they're IPv7, of course; IPv6 is much too limited). You'd like to figure out which IPs support TLS (transport-layer snooping).

        An IP supports TLS if it has an Autonomous Bridge Bypass Annotation, or ABBA. An ABBA is any four-character sequence which consists of a pair of two different characters followed by the reverse of that pair, such as xyyx or abba. However, the IP also must not have an ABBA within any hypernet sequences, which are contained by square brackets.

        For example:

        abba[mnop]qrst supports TLS (abba outside square brackets).
        abcd[bddb]xyyx does not support TLS (bddb is within square brackets, even though xyyx is outside square brackets).
        aaaa[qwer]tyui does not support TLS (aaaa is invalid; the interior characters must be different).
        ioxxoj[asdfgh]zxcvbn supports TLS (oxxo is outside square brackets, even though it's within a larger string).
        How many IPs in your puzzle input support TLS?"
    }
    Part-2: {
        You would also like to know which IPs support SSL (super-secret listening).

        An IP supports SSL if it has an Area-Broadcast Accessor, or ABA, anywhere in the supernet sequences (outside any square bracketed sections), and a corresponding Byte Allocation Block, or BAB, anywhere in the hypernet sequences. An ABA is any three-character sequence which consists of the same character twice with a different character between them, such as xyx or aba. A corresponding BAB is the same characters but in reversed positions: yxy and bab, respectively.

        For example:

        aba[bab]xyz supports SSL (aba outside square brackets with corresponding bab within square brackets).
        xyx[xyx]xyx does not support SSL (xyx, but no corresponding yxy).
        aaa[kek]eke supports SSL (eke in supernet with corresponding kek in hypernet; the aaa sequence is not related, because the interior character must be different).
        zazbz[bzb]cdb supports SSL (zaz has no corresponding aza, but zbz has a corresponding bzb, even though zaz and zbz overlap).
        How many IPs in your puzzle input support SSL?
    }
]

samples: [
    "abba[mnop]qrst"
    "abcd[bddb]xyyx"
    "aaaa[qwer]tyui"
    "ioxxoj[asdfgh]zxcvbn"
]

samples2: [
    "aba[bab]xyz"
    "xyx[xyx]xyx"
    "aaa[kek]eke"
    "zazbz[bzb]cdb"
]

alpha: charset [#"a" - #"z"]
abba: [copy a alpha copy b alpha if (a <> b) b a]
hypernet: [#"[" any [not ahead abba alpha] #"]"]
non-abba: [not ahead abba [hypernet | alpha]]

IPv7: [any non-abba abba any [abba | non-abba]]

aba: [copy a alpha copy b alpha if (a <> b) a]

get-abas: func [ip][
    parse ip [collect [any [
        ahead keep aba skip
        | "[" thru "]"
        | skip
    ]]]
]

has-bab?: function [ip aba][
    bab: rejoin [aba/2 aba/1 aba/2]
    non-bab: [not ahead bab alpha]
    hypernet-bab: ["[" any non-bab bab thru "]"]
    parse ip [to hypernet-bab to end]
]

where: function [block pred][
    collect [
        foreach i block [if pred i [keep/only i]]
    ]
]

curry: function [f [any-function!] x][
    function [y] reduce [:f x 'y]
]

probe length? where samples function [ip][parse ip IPv7]

probe length? where inputs: read/lines %day-7-input.txt function [ip][parse ip IPv7]

probe length? where inputs function [ip][
    ip-has-bab?: curry :has-bab? ip
    positive? length? where get-abas ip :ip-has-bab?
]