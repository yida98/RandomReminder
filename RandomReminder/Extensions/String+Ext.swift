//
//  String+Ext.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation

extension String {
    mutating func replace(_ element: Character, at index: String.Index) {
        self.remove(at: index)
        self.insert(element, at: index)
    }
    
    mutating func captalized() -> String {
        let first = Character(self.first!.uppercased())
        self.replace(first, at: self.startIndex)
        return self
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }

    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
}
