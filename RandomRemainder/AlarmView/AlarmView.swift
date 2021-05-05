//
//  AlarmView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import SwiftUI

struct AlarmView: View {
    
    var alarm: Alarm
    @EnvironmentObject var viewModel: AlarmViewModel
    @GestureState private var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            AlarmTools()
                .environmentObject(viewModel)
            Group {
                VStack(alignment: .leading) {
                    Text(alarm.descriptionBuilder())
                    Text(alarm.text)
                }
                .modifier(AlarmViewModifier())
            }
            .offset(x: viewModel.location.x)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if viewModel.difference == nil {
                            viewModel.difference = value.location.x - viewModel.location.x
                        }
                        viewModel.location.x += value.location.x - viewModel.difference!
                        viewModel.location.x = viewModel.location.x * Constants.movementScale
                    })
                    .onEnded({ value in
                        viewModel.difference = nil
                        viewModel.location.x = 0
                    })
            )
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(alarm: Alarm(text: "Wub"))
    }
}
