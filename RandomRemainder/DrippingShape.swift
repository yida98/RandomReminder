//
//  DrippingShape.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-05.
//

import Foundation
import SwiftUI

struct DrippingShape: Shape {
    
    @Binding var location: CGPoint
    
    init(location: Binding<CGPoint>) {
        self._location = location
    }
    
    var animatableData: CGPoint.AnimatableData {
        get { return CGPoint.AnimatableData(location.x, location.y) }
        set { location = CGPoint(x: newValue.first, y: newValue.second) }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let topL = CGPoint(x: rect.minX, y: rect.minY)
        let topR = CGPoint(x: rect.maxX, y: rect.minY)
        let botR = CGPoint(x: rect.maxX, y: rect.maxY)
        let botL = CGPoint(x: rect.minX, y: rect.maxY)
        let botC = CGPoint(x: (botL.x + botR.x)/2, y: rect.maxY + location.y)
        path.move(to: topL)
        path.addLine(to: topR)
        path.addLine(to: botR)
        
        let control1 = CGPoint(x: botR.x - 30, y: botR.y)
        let control2 = CGPoint(x: botC.x + 70, y: botC.y)
        path.addCurve(to: botC, control1: control1, control2: control2)
        
        let control3 = CGPoint(x: botC.x - 70, y: botC.y)
        let control4 = CGPoint(x: botL.x + 30, y: botL.y)
        path.addCurve(to: botL, control1: control3, control2: control4)
                
        path.closeSubpath()
        
        return path
    }
}
