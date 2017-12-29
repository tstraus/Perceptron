import random

proc boolinator*() =
    randomize()

proc nextBool*(): bool =
    result = false
    if random(2) == 1:
        result = true