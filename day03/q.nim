import strutils
import sequtils
import std/enumerate, std/strformat

proc isEligibleSymbol(c: char): bool =
    c != '.' and not c.isAlphaNumeric()

proc getNumbersFromInput(input: string): seq[int] = 
    let lines = input.splitLines()
    # Line index, start row index, end row index
    var foundNumberBounds: seq[(int, int, int)]

    var inNumberRange = false
    var numberRangeStart = -1
    for line_index, line in enumerate(lines):
        for character_index, character in enumerate(line):
            if character.isDigit():
                if not inNumberRange:
                    inNumberRange = true
                    numberRangeStart = character_index
            
            elif inNumberRange: # Number range has just ended
                inNumberRange = false
                foundNumberBounds.add((line_index, numberRangeStart, character_index-1))
                numberRangeStart = -1
        
        if inNumberRange:
            inNumberRange = false
            foundNumberBounds.add((line_index, numberRangeStart, line.high))
            numberRangeStart = -1

    for (line_index, start_i, end_i) in foundNumberBounds:
        var charactersToCheck = ""

        # Check row above
        if line_index > 0:
            charactersToCheck
                .add(lines[line_index-1][max(0, start_i-1) .. min(lines[0].high, end_i+1)])

        # Check adjacent cells
        if start_i > 0:
            charactersToCheck.add(lines[line_index][start_i-1])
        if end_i < lines[0].high:
            charactersToCheck.add(lines[line_index][end_i+1])

        # Check row below
        if line_index < lines.high-1:
            charactersToCheck
                .add(lines[line_index+1][max(0, start_i-1) .. min(lines[0].high, end_i+1)])

        let neighboursContainSymbol = charactersToCheck
            .toSeq()
            .mapIt(it.isEligibleSymbol)
            .foldl(a or b)

        if neighboursContainSymbol:
            result.add(lines[line_index][start_i .. end_i].parseInt)

# Q1
let q1result = readFile("q1.txt")
    .getNumbersFromInput()
    .foldl(a + b)
echo "Q1: ", q1result


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
assert input.getNumbersFromInput() == [
    467, 35, 633, 617, 592, 755, 664, 598
]
