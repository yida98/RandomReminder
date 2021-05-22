//
//  DrippingShape.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-05.
//

import Foundation
import SwiftUI

struct DrippingShape: Shape {
    
    var location: CGPoint
    private var initialValue: CGPoint = CGPoint(x: 0, y: Constants.scrollViewOffset)
    static var maxDrip: CGFloat = 190
    
    private static var curveControl1: CGFloat = 80
    private static var curveControl2: CGFloat = 30
    
    init(location: CGPoint) {
        self.location = location
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topL = CGPoint(x: rect.minX, y: rect.minY)
        let topR = CGPoint(x: rect.maxX, y: rect.minY)
        let botR = CGPoint(x: rect.maxX, y: rect.maxY)
        let botL = CGPoint(x: rect.minX, y: rect.maxY)
        var botC = CGPoint(x: CGFloat(botL.x + botR.x)/2, y: rect.maxY)
        if location.y > initialValue.y {
            let y = min(rect.maxY + (location.y*0.5) - (initialValue.y/2), DrippingShape.maxDrip)
            botC = CGPoint(x: (botL.x + botR.x)/2, y: y)
        }
        path.move(to: topL)
        path.addLine(to: topR)
        path.addLine(to: botR)
        
        let control1 = CGPoint(x: botR.x - DrippingShape.curveControl2, y: botR.y)
        let control2 = CGPoint(x: botC.x + DrippingShape.curveControl1, y: botC.y)
        path.addCurve(to: botC, control1: control1, control2: control2)
        
        let control3 = CGPoint(x: botC.x - DrippingShape.curveControl1, y: botC.y)
        let control4 = CGPoint(x: botL.x + DrippingShape.curveControl2, y: botL.y)
        path.addCurve(to: botL, control1: control3, control2: control4)
                
        path.closeSubpath()
        
        return path
    }
}
