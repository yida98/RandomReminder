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

    var body: some View {
        VStack {
            DrippingShape(location: $viewModel.location)
                .fill(Color.blue)
                .frame(height: 120)
            ZStack {
                VStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: Constants.circleM, height: Constants.circleM)
                    Spacer()
                }
                PositionScrollView(location: $viewModel.location) {
                    ForEach(storage.alarms) { alarm in
                        AlarmView()
                            .environmentObject(AlarmViewModel(alarm: alarm))
                            .padding(.bottom, 20)
                    }

                }
//                ScrollView {
//                    ForEach(storage.alarms) { alarm in
//                        AlarmView()
//                            .environmentObject(AlarmViewModel(alarm: alarm))
//                            .padding(.bottom, 20)
//                    }
//                }
//                .simultaneousGesture(
//                    DragGesture().onChanged({ value in
//                        if viewModel.difference == nil {
//                            viewModel.difference = value.location.y - viewModel.location.y
//                        }
//                        viewModel.location.y = (viewModel.location.y +
//                                                    value.location.y -
//                                                    viewModel.difference!) *
//                                                Constants.movementScale
//                    })
//                    .onEnded({ value in
//                        viewModel.difference = nil
//                        viewModel.location.y = 0
//                    })
//                )
            }
            NavigationView {
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif
                    Spacer()
                    Button(action: viewModel.addAlarm) {
                        Label("Add Item", systemImage: "plus")
                    }
                }.padding()
            }
        }.background(Color.white)
        .ignoresSafeArea()
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
