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
                    AlarmView()
                        .environmentObject(AlarmViewModel(alarm: alarm))
                        .padding(.bottom, 20)
                        .onTapGesture {
                            print(alarm)
                        }
                }
            })
        }.background(Color.white)
        .ignoresSafeArea()
        .modifier(OverlayModifier(isPresenting: $viewModel.isPresenting, viewModel: viewModel))
        
    }
}

struct OverlayModifier: ViewModifier {
    
    var isPresenting: Binding<Bool>
    var viewModel: ContentViewModel
    
    init(isPresenting: Binding<Bool>, viewModel: ContentViewModel) {
        self.isPresenting = isPresenting
        self.viewModel = viewModel
    }
    
    func body(content: Content) -> some View {
        if viewModel.isPresenting {
            if viewModel.adding {
                content
                    .overlay(
                        PopoutAlarmView<CreateAlarmViewModel>(isPresenting: isPresenting).environmentObject(CreateAlarmViewModel())
                    )
            } else {
                if viewModel.tappedAlarm != nil {
                    content
                        .overlay(
                            PopoutAlarmView<ModifyAlarmViewModel>(isPresenting: isPresenting).environmentObject(ModifyAlarmViewModel(alarm: viewModel.tappedAlarm!))
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
