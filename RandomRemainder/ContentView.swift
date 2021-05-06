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
            TitleBar().environmentObject(viewModel)
            ZStack {
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
