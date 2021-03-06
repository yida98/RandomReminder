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
    static let inset: CGFloat = Constants.insetSize.width/2 + AlarmTools.padding
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(viewModel.snooze ? Color.blue : Constants.backgroundColor)
                    .scaleEffect(viewModel.snooze ? 1 : 0.5, anchor: .center)
                    .modifier(CircleHaptic(condition: viewModel.snooze))
                Image(systemName: "moon.zzz.fill")
                    .foregroundColor(Constants.backgroundColor)
            }
            .padding(.leading, AlarmTools.inset)
            Spacer()
            ZStack {
                Circle()
                    .fill(viewModel.delete ? Color.red : Constants.backgroundColor)
                    .scaleEffect(viewModel.delete ? 1 : 0.5, anchor: .center)
                    .modifier(CircleHaptic(condition: viewModel.delete))
                Image(systemName: "trash.fill")
                    .foregroundColor(Constants.backgroundColor)
            }
            .padding(.trailing, AlarmTools.inset)
        }.alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Delete \(viewModel.alarm.text)?"),
                primaryButton: .cancel(),
                secondaryButton: .destructive(Text("Confirm"), action: {
                    viewModel.deleteAlarm()
                }))
        }
    }
}

struct CircleHaptic: ViewModifier {
    
    var condition: Bool
    
    func body(content: Content) -> some View {
        content
            .frame(width: Constants.circleS, height: Constants.circleS)
            .animation(.easeOut)
            .onChange(of: condition) { some in
                Constants.hapticFeedback(.medium)
            }
    }
}
