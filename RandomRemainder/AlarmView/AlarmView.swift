//
//  AlarmView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import SwiftUI

struct AlarmView: View {
    
    @EnvironmentObject var viewModel: AlarmViewModel
    @GestureState private var isDragging: Bool = false
    
    var body: some View {
        ZStack {
            AlarmTools()
                .environmentObject(viewModel)
            Group {
                HStack{
                    VStack(alignment: .leading) {
                        Text(viewModel.alarm.descriptionBuilder())
                            .font(.caption)
                        Text(viewModel.alarm.text)
                    }
                    Spacer()
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
                        viewModel.location.x = (viewModel.location.x +
                                                    value.location.x -
                                                    viewModel.difference!) *
                                                Constants.movementScale
                    })
                    .onEnded({ value in
                        viewModel.difference = nil
                        if viewModel.snooze {
                            viewModel.snoozeAlarm()
                        }
                        if viewModel.delete {
                            viewModel.deleteAlarm()
                        }
                        viewModel.location.x = 0
                    })
            )
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
