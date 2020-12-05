import UIKit

extension StringProtocol {
    subscript(offset: Int) -> Character? {
        self[index(startIndex, offsetBy: offset)]
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

func calculateSeatID(using pass: String) -> Int {
    var minRow = 0
    var maxRow = 127
    var minColumn = 0
    var maxColumn = 7
    
    var row = 0
    var column = 0

    for char in pass {
        var rowMidPoint = (maxRow + minRow) / 2
        var columnMidPoint = (maxColumn + minColumn) / 2
        
        if char == "F" {
            maxRow = rowMidPoint
        }
        
        if char == "B" {
            rowMidPoint += 1
            minRow = rowMidPoint
        }
        
        if char == "R" {
            columnMidPoint += 1
            minColumn = columnMidPoint
        }
        
        if char == "L" {
            maxColumn = columnMidPoint
        }
        
        row = rowMidPoint
        column = columnMidPoint
    }

    return (row * 8) + column
}

func getCorrectSeatID(_ passesString: String) -> Int {
    let passes = passesString.components(separatedBy: CharacterSet.whitespacesAndNewlines)
    
    var maxID = Int.min
    var minID = Int.max
    var seatIDs: [Int] = []
    
    for pass in passes {
        let seatID = calculateSeatID(using: pass)
        
        seatIDs.append(seatID)
        maxID = max(maxID, seatID)
        minID = min(minID, seatID)
    }
    
    for seat in minID..<maxID {
        if !seatIDs.contains(seat) {
            return seat
        }
    }
    
    return 0
}
