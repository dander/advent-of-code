Red [
    Title: "download puzzle input"
    Author: "Dave Andersen"
]

get-input: function ["Get the local file containing the puzzle input (downloading it if necessary)" year day][
    input-file: rejoin [%day day "-input.txt"]
    download-link: rejoin [https://adventofcode.com/ year "/day/" day "/input"]
    if not exists? input-file [
        unless exists? %session-cookie.txt [
            do make error! {No session cookie: To get it, login to adventofcode.com, open the browser dev tools, navigate to "cookies" and copy the value of the "session" cookie into %session-cookie.txt"}
        ]
        cookie: rejoin ["session=" read %session-cookie.txt]
        response: write/info download-link compose/deep [
            GET
            [Cookie: (cookie)]
        ]
        write input-file response/3
    ]
    input-file
]

read-input: function ["Get puzzle input as a string!" year day][
    read get-input year day
]
