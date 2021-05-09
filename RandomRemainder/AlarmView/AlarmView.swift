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
                    Circle()
                        .fill(Color.orange)
                        .frame(width: Constants.circleS, height: Constants.circleS)
                        .overlay(
                            Text(String(viewModel.alarm.occurence))
                                .foregroundColor(Color.white)
                                .font(.title)
                        )
                }
                .modifier(AlarmViewModifier())
            }
            .offset(x: viewModel.location.x)
            .gesture(
                TapGesture().simultaneously(with: 
                    DragGesture(minimumDistance: 1, coordinateSpace: .local)
                        .onChanged({ value in
                            viewModel.location.x = (viewModel.location.x +
                                                        value.location.x -
                                                        value.startLocation.x) *
                                                    Constants.movementScale
                        }).updating($isDragging, body: { value, state, transaction in
                            state = true
                        })
                        .onEnded({ value in
                            if viewModel.snooze {
                                viewModel.snoozeAlarm()
                            }
                            if viewModel.delete {
                                viewModel.deleteAlarm()
                            }
                            viewModel.location.x = 0
                        })
                                       )
            )
        }
        .simultaneousGesture(TapGesture().onEnded({ _ in
                print("tapping")
                viewModel.isPresenting = true
        }))
        
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
