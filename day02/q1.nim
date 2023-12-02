import sequtils
import strutils

type CubeCounts* = tuple
    red, green, blue: int

proc readMinCubeCountsFromDraw*(draw: string): (int, CubeCounts) = 
    var cc: CubeCounts = (0, 0, 0)
    var gameNumber = 0

    let lines = draw.split(":")
    gameNumber = lines[0].splitWhitespace()[1].parseInt

    let drawLines = lines[1].split(";")
    for drawLine in drawLines:
        let draws = drawLine.split(",")
        for draw in draws:
            let splitDraw = draw.strip().split(" ")
            let drawnCount = splitDraw[0].parseInt()

            case splitDraw[1]:
                of "red":
                    if drawnCount > cc.red: cc.red = drawnCount
                of "blue":
                    if drawnCount > cc.blue: cc.blue = drawnCount
                of "green":
                    if drawnCount > cc.green: cc.green = drawnCount

    return (gameNumber, cc)

let idSum = readFile("q1.txt")
    .splitLines
    .toSeq
    .map(readMinCubeCountsFromDraw)
    .filterIt(it[1].red <= 12 and it[1].green <= 13 and it[1].blue <= 14)
    .mapIt(it[0])
    .foldl(a + b)
echo idSum

assert readMinCubeCountsFromDraw("Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green") == (1, (4, 2, 6))
assert readMinCubeCountsFromDraw("Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue") == (2, (1, 3, 4))
assert readMinCubeCountsFromDraw("Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red") == (3, (20, 13, 6))
assert readMinCubeCountsFromDraw("Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red") == (4, (14, 3, 15))
assert readMinCubeCountsFromDraw("Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green") == (5, (6, 3, 2))
