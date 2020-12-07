import UIKit

extension StringProtocol {
    subscript(offset: Int) -> Character? {
        self[index(startIndex, offsetBy: offset)]
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}

func getGroupCount(group: [String]) -> Int {
    let set: Set<Character> = []
    
    return group.reduce(into: set) { result, value in
        result.formUnion(value)
    }.count
}

func getSum(_ input: String) -> Int {
    let lines = input.components(separatedBy: "\n\n")

    var sum = 0
    
    for line in lines {
        let words = line.components(separatedBy: .whitespacesAndNewlines)
        sum += getGroupCount(group: words)
    }
    
    return sum
}
