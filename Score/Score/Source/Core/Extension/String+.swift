//
//  String+.swift
//  Score
//
//  Created by sole on 8/25/24.
//

extension String {
    subscript(range: Range<Int>) -> Self {
        let startIndex = self.startIndex
        let lastIndex = self.index(startIndex, offsetBy: range.upperBound)
        return String(self[startIndex..<lastIndex])
    }
    
    subscript(range: ClosedRange<Int>) -> Self {
        let startIndex = self.startIndex
        let lastIndex = self.index(startIndex, offsetBy: range.upperBound)
        return String(self[startIndex...lastIndex])
    }
}
