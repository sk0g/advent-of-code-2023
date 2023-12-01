import sequtils
import std/strutils
from strformat import fmt

# PART 2
proc getCalibrationValue2(input: string): int =
    # Dirty hacks
    var correctedInput = input.multiReplace(
        # Dirty hacks below
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
    correctedInput = correctedInput.multiReplace(
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
    var digits = toSeq(correctedInput.items)
        .filterIt(it.isDigit)
        .mapIt(fmt"{it}".parseInt)

    return digits[0] * 10 + digits[digits.high]


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

proc q2() =
    let values = readFile("q1.txt")
        .splitLines
        .toSeq
        .map(getCalibrationValue2)
    echo "q2: ", values.foldl(a + b)

q2()