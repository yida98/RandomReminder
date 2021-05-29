//
//  ContentView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-02.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    @ObservedObject var storage: Storage = Storage.shared
    @GestureState var isDragging: Bool = false 
    var body: some View {
        ZStack {
            VStack {
                TitleBar()
                    .environmentObject(viewModel)
                PositionScrollView(
                    axes: .vertical,
                    showIndicators: true,
                    offsetChanged: { point in
                        viewModel.location = point
                        if viewModel.location.y >= DrippingShape.maxDrip
                            && viewModel.isReady == false {
                            viewModel.isReady = true
                        }
                        if viewModel.location.y <= Constants.scrollViewOffset {
                            viewModel.isReady = false
                        }
                }, content: {
                    HStack {
                        Text("Alarms")
                            .font(.title2)
                            .foregroundColor(Constants.secondaryColour.opacity(0.6))
                        Spacer()
                    }.padding(.horizontal, Constants.insetSize.width / 2)
                        
                    ForEach(storage.alarms) { alarm in
                        AlarmView(isTapped: $viewModel.tappedAlarm)
                            .environmentObject(AlarmViewModel(alarm: alarm))
                            .padding(.bottom, 20)
                    }
                })
            }.background(Constants.backgroundColor)
            .ignoresSafeArea()
            .modifier(OverlayModifier(isPresenting: $viewModel.isPresenting, adding: $viewModel.adding, alarm: $viewModel.tappedAlarm, viewModel: viewModel))
            AlertView(isPresenting: !viewModel.allowsNotification) {
                Button {
                    viewModel.openSettings()
                } label: {
                    HStack {
                        Text("Please enable notifications")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Image(systemName: "arrowshape.turn.up.right.circle.fill")
                            .foregroundColor(.lightGrey)
                    }
                }
            }
        }
        
    }
}

fileprivate struct OverlayModifier: ViewModifier {
    
    var isPresenting: Binding<Bool>
    var adding: Binding<Bool>
    var alarm: Binding<Alarm?>
    var viewModel: ContentViewModel
    
    init(isPresenting: Binding<Bool>, adding: Binding<Bool>, alarm: Binding<Alarm?>, viewModel: ContentViewModel) {
        self.isPresenting = isPresenting
        self.adding = adding
        self.alarm = alarm
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        if viewModel.isPresenting {
            if viewModel.adding {
                content
                    .overlay(
                        PopoutAlarmView<CreateAlarmViewModel>(isPresenting: isPresenting, adding: adding, alarm: alarm).environmentObject(CreateAlarmViewModel())
                    )
            } else {
                if viewModel.tappedAlarm != nil {
                    content
                        .overlay(
                            PopoutAlarmView<ModifyAlarmViewModel>(isPresenting: isPresenting, adding: adding, alarm: alarm).environmentObject(ModifyAlarmViewModel(alarm: viewModel.tappedAlarm!))
                        )
                } else {
                    content
                }
            }
        } else {
            content
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
