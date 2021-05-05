//
//  AlarmViewModifier.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import Foundation
import SwiftUI

struct AlarmViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        VStack {
            content
                .padding()
        }
        .frame(width: Constants.screenSize.width - Constants.insetSize.width)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.lightGrey2, radius: 6, y: 3)
        .padding(.horizontal, Constants.insetSize.width/2)
        .animation(.easeIn)
    }
    
}
