//
//  AllowNotificationsScreen.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-09.
//

import SwiftUI

struct AllowNotificationsScreen: View {
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            Text("Please allow notifications.")
            Button {
                viewModel.openSettings()
            } label: {
                Text("Go to settings")
            }.buttonStyle(BasicButtonStyle())
        }.frame(width: Constants.screenSize.width, height: Constants.screenSize.height)
        .background(Color.white)
        .ignoresSafeArea()
    }
}

struct AllowNotificationsScreen_Previews: PreviewProvider {
    static var previews: some View {
        AllowNotificationsScreen()
    }
}
