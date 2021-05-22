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
        
    @Binding var isTapped: Alarm?
    
    var body: some View {
        ZStack {
            AlarmTools()
                .environmentObject(viewModel)
            VStack {
                VStack (alignment: .leading) {
                    HStack {
                        Text(viewModel.alarm.descriptionBuilder())
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.gray)
                            .lineLimit(nil)
                    }
                    
                    HStack {
                        Text(viewModel.alarm.text)
                            .foregroundColor(viewModel.alarm.snoozed ? .gray : .darkGrey)
                            .lineLimit(nil)
                        Spacer()
                        
                        Text(String(viewModel.alarm.occurence))
                            .padding(4)
                            .foregroundColor(Color.white)
                            .font(.title)
                            .background(viewModel.alarm.snoozed ? Color.gray : Constants.secondaryColour)
                            .cornerRadius(5)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Constants.lowlightColour, lineWidth: 1)
                            )
                    }
                    
                }
                .modifier(AlarmViewModifier(snoozed: viewModel.alarm.snoozed))
                
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
                                viewModel.deleteAlarmCheck()
                            }
                            viewModel.location.x = 0
                        })
                                       )
            )
        }
        .simultaneousGesture(TapGesture().onEnded({ _ in
                isTapped = viewModel.alarm
        }))
        
    }
}
