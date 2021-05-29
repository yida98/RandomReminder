//
//  AlarmViewModifier.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import Foundation
import SwiftUI

struct AlarmViewModifier: ViewModifier {
    
    var snoozed: Bool
    
    init(snoozed: Bool) {
        self.snoozed = snoozed
    }
    
    func body(content: Content) -> some View {
        Group {
            content
                .padding(30)
        }
        .frame(width: Constants.screenSize.width - Constants.insetSize.width)
        .background(snoozed ? Color.lightGrey2 : Color.white)
        .cornerRadius(15)
        .shadow(color: snoozed ? Color.clear : Color.lightGrey2, radius: 6, y: 3)
        .padding(.horizontal, Constants.insetSize.width/2)
        .animation(.easeIn)
    }
    
}
