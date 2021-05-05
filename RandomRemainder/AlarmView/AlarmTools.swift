//
//  AlarmTools.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import SwiftUI

struct AlarmTools: View {
    
    @EnvironmentObject var viewModel: AlarmViewModel
    
    static let spaceBetween: CGFloat = 20
    static let padding: CGFloat = 10
    
    var body: some View {
        HStack {
            Spacer()
            ZStack {
                Circle()
                    .fill(viewModel.delete ? Color.red : Color.lightGrey3)
                    .scaleEffect(viewModel.delete ? 1 : 0.7, anchor: .center)
                    .modifier(CircleHaptic(condition: $viewModel.snooze))
                Image(systemName: "trash.fill")
                    .foregroundColor(Color.white)
            }
            .padding(.trailing, AlarmTools.spaceBetween)
            
            ZStack {
                Circle()
                    .fill(viewModel.snooze ? Color.blue : Color.lightGrey3)
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
            .frame(width: Constants.circleS, height: Constants.circleS)
            .animation(.easeOut)
            .onChange(of: condition) { some in
                Constants.hapticFeedback(.medium)
            }
    }
}
