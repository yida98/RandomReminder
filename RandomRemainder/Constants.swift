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
        
    static let circleXS: CGFloat = 20
    static let circleS: CGFloat = 40
    static let circleM: CGFloat = 60
    static let circleL: CGFloat = 80
    
    static let movementScale: CGFloat = 0.4
    
    static func hapticFeedback(_ intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        let impactMed = UIImpactFeedbackGenerator(style: intensity)
        impactMed.impactOccurred()
    }
    
    static let navBarHeight: CGFloat = 80
    static let scrollViewOffset: CGFloat = Constants.navBarHeight + 8
    
    static let highlightColour: Color = Color.green
}

extension Color {
    static let darkGrey: Color = Color(white: 0.25)
    static let darkGrey2: Color = Color(white: 0.2)
    static let darkGrey3: Color = Color(white: 0.15)
    
    static let lightGrey: Color = Color(white: 0.85)
    static let lightGrey2: Color = Color(white: 0.9)
    static let lightGrey3: Color = Color(white: 0.95)
}
