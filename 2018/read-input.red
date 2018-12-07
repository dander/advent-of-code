Red [
    Title: "download puzzle input"
]

get-input: function [day /lines][
    input-file: rejoin [%day day "-input.txt"]
    download-link: rejoin [https://adventofcode.com/2018/day/ day "/input"]
    if not exists? input-file [
        cookie: rejoin ["session=" read %session-cookie.txt]
        response: write/info download-link compose/deep [
            GET
            [Cookie: (cookie)]
        ]
        write input-file response/3
    ]
    input-file
]

read-input: function [day][
    read get-input day
]
