//
//  Constants.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import Foundation
import SwiftUI

struct Constants {
    
    static let screenSize: CGRect = UIWindow().bounds
    static let insetSize: CGSize = CGSize(width: 60, height: 60)
    
    static let circleS: CGFloat = 40
    static let circleM: CGFloat = 60
    static let circleL: CGFloat = 80
    
    static let movementScale: CGFloat = 0.4
    
    static func hapticFeedback(_ intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        let impactMed = UIImpactFeedbackGenerator(style: intensity)
        impactMed.impactOccurred()
    }
}

extension Color {
    static let lightGrey: Color = Color(white: 0.85)
    static let lightGrey2: Color = Color(white: 0.9)
    static let lightGrey3: Color = Color(white: 0.95)
}
