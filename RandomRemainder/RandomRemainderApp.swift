//
//  RandomRemainderApp.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-02.
//

import SwiftUI

@main
struct RandomRemainderApp: App {
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ContentViewModel())
        }
        .onChange(of: scenePhase) { _ in
//            persistenceController.save()
        }
    }
}
