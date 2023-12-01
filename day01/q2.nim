import sequtils
import std/strutils
from strformat import fmt

proc getCalibrationValue2(input: string): int =
    # Dirty hacks: some numbers have their last character overlap
    # with the first character of their first letter.
    # Get around that by simply duplicating the final character for each number...
    let fixedInput = input
        .multiReplace(
            ("one", "onee"),
            ("two", "twoo"),
            ("three","threee"),
            ("four", "fourr"),
            ("five","fivee"),
            ("six", "sixx"),
            ("seven","sevenn"),
            ("eight","eightt"),
            ("nine","ninee")
        )
        .multiReplace(
            ("one", "1"),
            ("two", "2"),
            ("three", "3"),
            ("four", "4"),
            ("five", "5"),
            ("six", "6"),
            ("seven", "7"),
            ("eight", "8"),
            ("nine", "9"),
        )
    let digits = toSeq(fixedInput.items)
        .filter(isDigit)
        .mapIt(fmt"{it}".parseInt)

    return digits[0] * 10 + digits[digits.high]

let values = readFile("q1.txt")
    .splitLines
    .toSeq
    .map(getCalibrationValue2)
echo "q2: ", values.foldl(a + b)


assert "two1nine".getCalibrationValue2 == 29
assert "eightwothree".getCalibrationValue2 == 83
assert "abcone2threexyz".getCalibrationValue2 == 13
assert "xtwone3four".getCalibrationValue2 == 24
assert "4nineeightseven2".getCalibrationValue2 == 42
assert "zoneight234".getCalibrationValue2 == 14
assert "7pqrstsixteen".getCalibrationValue2 == 76
# Overlap checks
assert "eighthree".getCalibrationValue2 == 83
assert "sevenine".getCalibrationValue2 == 79
assert "oneight".getCalibrationValue2 == 18
