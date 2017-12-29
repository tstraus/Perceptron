import random

var first = true

proc nextBool*(): bool =
    if first:
        randomize()
        first = false

    result = false
    if random(2) == 1:
        result = true