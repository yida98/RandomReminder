//
//  Array+Ext.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-20.
//

import Foundation

extension Array where Element: Comparable {
    func isAscending() -> Bool {
        if self.count <= 1 { return true }
        var i = 1
        while i < self.count {
            if self[i - 1] > self[i] {
                return false
            }
            i += 1
        }
        return true
    }
}

extension Array {
    func toTuple() throws -> [(Element, Element)] {
        if self.count % 2 != 0 {
            throw ArrayError.ArrayLengthError
        }
        var result = [(Element, Element)]()
        var i = 1
        
        while i <= self.count / 2 {
            result.append((self[i - 1], self[i]))
            i += 1
        }
        
        return result
    }
    
    enum ArrayError: Error {
        case ArrayLengthError
    }
}
