//
//  AlarmTools.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import SwiftUI

struct AlarmTools: View {
    
    @Binding var xValue: CGFloat
    
    static private var graceLength: CGFloat = 30
    static private var firstBound: CGFloat = -(Constants.insetSize.width/2 + 10 + AlarmTools.graceLength)
    static private var secondBound: CGFloat = -(-AlarmTools.firstBound + 25 + AlarmTools.graceLength)
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(xValue < AlarmTools.secondBound ? Color.red : Color.white)
                    .scaleEffect(xValue < AlarmTools.secondBound ? 1 : 0.7, anchor: .center)
                    .frame(width: 40, height: 40)
                    .animation(.easeOut)
                Image(systemName: "trash.fill")
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, 25)
            
            ZStack {
                Circle()
                    .fill((xValue < AlarmTools.firstBound && xValue > AlarmTools.secondBound) ? Color.blue : Color.white)
                    .scaleEffect((xValue < AlarmTools.firstBound && xValue > AlarmTools.secondBound) ? 1 : 0.7, anchor: .center)
                    .frame(width: 40, height: 40)
                    .animation(.easeOut)
                Image(systemName: "moon.zzz.fill")
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, Constants.insetSize.width/2 + 10)
        }
    }
}

struct CircleHaptic: ViewModifier {
    func body(content: Content) -> some View {
        <#code#>
    }
}
