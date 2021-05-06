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
            ZStack {
                DrippingShape(location: viewModel.location)
                    .fill(Constants.highlightColour)
                    .frame(height: 120)
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: Constants.circleS, height: Constants.circleS)
                    Circle()
                        .fill(Constants.highlightColour)
                        .frame(
                            width: Constants.circleS * viewModel.scale,
                            height: Constants.circleS * viewModel.scale
                        )
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Constants.highlightColour)
                        .frame(width: Constants.circleS*0.4, height: Constants.circleS*0.4)
                
                }.offset(y: 90)
                .mask(
                    DrippingShape(location: viewModel.location)
                        .fill(Constants.highlightColour)
                        .frame(height: 120)
                )
            }
                
            ZStack {
//                VStack {
//                    ZStack {
//                        Circle()
//                            .fill(Color.white)
//                            .frame(width: Constants.circleS, height: Constants.circleS)
//                        Circle()
//                            .fill(Color.blue)
//                            .frame(
//                                width: Constants.circleS * viewModel.scale,
//                                height: Constants.circleS * viewModel.scale
//                            )
//                        Image(systemName: "plus")
//                            .resizable()
//                            .foregroundColor(Color.blue)
//                            .frame(width: Constants.circleS*0.4, height: Constants.circleS*0.4)
//                    }.padding(.top, 10)
//                    Spacer()
//                }
                PositionScrollView(
                    axes: .vertical,
                    showIndicators: true,
                    offsetChanged: { point in
                        viewModel.location = point
                }, content: {
                    ForEach(storage.alarms) { alarm in
                        AlarmView()
                            .environmentObject(AlarmViewModel(alarm: alarm))
                            .padding(.bottom, 20)
                    }
                })
            }
            HStack {
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
