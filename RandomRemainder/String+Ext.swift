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
}
