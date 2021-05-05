//
//  Time.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation

struct Time: Codable {
    var hour: Int
    var minute: Int
    var second: Int
}

extension Time {
    func toDateComponents() -> DateComponents {
        return DateComponents(hour: hour, minute: minute)
    }
}
