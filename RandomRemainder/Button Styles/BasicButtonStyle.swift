//
//  BasicButtonStyle.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-10.
//

import SwiftUI

struct BasicButtonStyle: ButtonStyle {
    
    let bgColor: Color
    init(_ bgColor: Color = .lightGrey3) {
        self.bgColor = bgColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        MyButton(bgColor, configuration: configuration)
    }
    
    struct MyButton: View {
        let configuration: BasicButtonStyle.Configuration
        let bgColor: Color
        
        init(_ backgrounColor: Color = .lightGrey3, configuration: BasicButtonStyle.Configuration) {
            self.bgColor = backgrounColor
            self.configuration = configuration
        }
        
        var body: some View {
            configuration.label
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .foregroundColor(Color.darkGrey)
                .background(configuration.isPressed ? Color.lightGrey : bgColor)
                .cornerRadius(5)
        }
    }
    
}
