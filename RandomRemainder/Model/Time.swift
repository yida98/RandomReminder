//
//  Time.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation

struct Time: Codable, Identifiable {
    var hour: Int
    var minute: Int
    var second: Int
    var id: Date = Date()
}

extension Time {
    func toDateComponents() -> DateComponents {
        return DateComponents(hour: hour, minute: minute)
    }
    static let zero = Time(hour: 0, minute: 0, second: 0)
}
