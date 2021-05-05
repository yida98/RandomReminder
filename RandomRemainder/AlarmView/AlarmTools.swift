//
//  AlarmTools.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import SwiftUI

struct AlarmTools: View {
    
    @EnvironmentObject var viewModel: AlarmViewModel
    
    static private var graceLength: CGFloat = 30
    static private var firstBound: CGFloat = -(Constants.insetSize.width/2 + 10 + AlarmTools.graceLength)
    static private var secondBound: CGFloat = -(-AlarmTools.firstBound + 25 + AlarmTools.graceLength)
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(viewModel.delete ? Color.red : Color.white)
                    .scaleEffect(viewModel.delete ? 1 : 0.7, anchor: .center)
                    .frame(width: 40, height: 40)
                    .animation(.easeOut)
                Image(systemName: "trash.fill")
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, 25)
            
            ZStack {
                Circle()
                    .fill(viewModel.snooze ? Color.blue : Color.white)
                    .scaleEffect(viewModel.snooze ? 1 : 0.7, anchor: .center)
                    .modifier(CircleHaptic(condition: $viewModel.snooze))
                Image(systemName: "moon.zzz.fill")
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, Constants.insetSize.width/2 + 10)
        }
    }
}

struct CircleHaptic: ViewModifier {
    
    @Binding var condition: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: 40, height: 40)
            .animation(.easeOut)
            .onChange(of: condition) { some in
                Constants.hapticFeedback(.medium)
            }
    }
}
