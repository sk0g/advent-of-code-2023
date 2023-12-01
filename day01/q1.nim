import sequtils
import std/strutils
from strformat import fmt

proc getCalibrationValue(input: string): int =
    var digits = toSeq(input.items)
        .filterIt(it.isDigit)
        .mapIt(fmt"{it}".parseInt)

    return digits[0] * 10 + digits[digits.high]


assert "1abc2".getCalibrationValue == 12
assert "pqr3stu8vwx".getCalibrationValue == 38
assert "a1b2c3d4e5f".getCalibrationValue == 15
assert "treb7uchet".getCalibrationValue == 77

proc q1() =
    let values = readFile("q1.txt")
        .splitLines
        .toSeq
        .map(getCalibrationValue)
    echo "q1: ", values.foldl(a + b)

q1()
