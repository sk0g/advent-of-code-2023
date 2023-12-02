import sequtils
import strutils
import q1

proc calculatePower(cc: CubeCounts): int =
    return cc.red * cc.green * cc.blue 

let idSum = readFile("q1.txt")
    .splitLines
    .toSeq
    .map(readMinCubeCountsFromDraw)
    .mapIt(it[1].calculatePower())
    .foldl(a + b)
echo idSum


assert "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
    .readMinCubeCountsFromDraw()[1].calculatePower() == 48
assert "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
    .readMinCubeCountsFromDraw()[1].calculatePower() == 12
assert "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
    .readMinCubeCountsFromDraw()[1].calculatePower() == 1560
assert "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
    .readMinCubeCountsFromDraw()[1].calculatePower() == 630
assert "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
    .readMinCubeCountsFromDraw()[1].calculatePower() == 36
