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
                    ForEach(storage.alarms) { alarm in
                        AlarmView(isTapped: $viewModel.tappedAlarm)
                            .environmentObject(AlarmViewModel(alarm: alarm))
                            .padding(.bottom, 20)
                    }
                })
            }.background(Constants.backgroundColor)
            .ignoresSafeArea()
            .modifier(OverlayModifier(isPresenting: $viewModel.isPresenting, adding: $viewModel.adding, alarm: $viewModel.tappedAlarm, viewModel: viewModel))
            if !viewModel.allowsNotification {
                AllowNotificationsScreen()
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
