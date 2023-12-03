import strutils
import sequtils
import std/enumerate

proc sumGearRatios(input: string): int = 
    let lines = input.splitLines()

    # Find all gears (* symbols)
    # Row, column
    var possibleGearIndices: seq[(int, int)]
    for line_index, line in enumerate(lines):
        for character_index, character in enumerate(line):
            if character == '*':
                possibleGearIndices.add((line_index, character_index))
    
    for (row, column) in possibleGearIndices:
        var numberIndicesAroundGears: seq[(int, int)]
        let gearNeighbours = [
            (row-1, column-1), (row-1, column), (row-1, column+1),
            (row, column-1), (row, column+1),
            (row+1, column-1), (row+1, column), (row+1, column+1)
        ]
        for (neighbourRow, neighbourColumn) in gearNeighbours:
            if neighbourRow < 0 or neighbourRow > lines.high:
                continue
            if neighbourColumn < 0 or neighbourColumn > lines[0].high:
                continue
            
            if lines[neighbourRow][neighbourColumn].isDigit():
                numberIndicesAroundGears.add((neighbourRow, neighbourColumn))

        var expandedNumberIndicesAroundGears: seq[(int, int, int)]
        for (row, column) in numberIndicesAroundGears:
            var start_i, end_i = column

            while start_i-1 >= 0 and lines[row][start_i-1].isDigit():
                start_i -= 1

            while end_i+1 <= lines[0].high and lines[row][end_i+1].isDigit():
                end_i += 1

            expandedNumberIndicesAroundGears.add(
                (row, start_i, end_i)
            )

        let deduplicatedNumberIndices = expandedNumberIndicesAroundGears.deduplicate()
        if deduplicatedNumberIndices.len == 2:
            var currentGearRatio = 1
            for (line_i, start_i, end_i) in deduplicatedNumberIndices:
                let number = lines[line_i][start_i .. end_i].parseInt
                currentGearRatio *= number

            result += currentGearRatio

let q2result = readFile("q1.txt")
    .sumGearRatios()
echo q2result

# ASSERTIONS
let input = """
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598..
"""

assert input.sumGearRatios() == 467835