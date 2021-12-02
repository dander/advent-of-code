# Advent of Code in [Red](https://www.red-lang.org/)

This is a small collection of solutions to [Advent of Code problems](https://adventofcode.com/), and a problem input downloader.

I mostly use Advent of Code to experiment with different ways of solving the problems, and tend to not get very far. I might have some weird solutions.

To use the input downloader, copy read-input.red to your workspace, and save your browser session cookie to `session-cookie.txt`.
![image](https://user-images.githubusercontent.com/1302979/144337211-eba206b5-71cb-43e2-9c81-b608f3b9290d.png)

Then put something like this at the top of your script:

```Red
#include %read-input.red

year: 2021
day: 1
problem-input: load read-input year day
; or maybe
problem-input-lines: read-lines get-input year day
```

It plays nice with the site, and only downloads the input a single time. After that, it will load from the cached version in the local directory.
