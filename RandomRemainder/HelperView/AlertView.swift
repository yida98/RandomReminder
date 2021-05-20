//
//  AlertView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-19.
//

import SwiftUI

struct AlertView<Content: View>: View {
    
    let message: String
    let content: Content
    
    init(message: String, @ViewBuilder content: () -> Content) {
        self.message = message
        self.content = content()
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .center, spacing: 10) {
                Text(message)
                    .foregroundColor(Color.darkGrey)
                content
            }.padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.4))
            .cornerRadius(15)
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(message: "This is a message") {
            
        }
    }
}
