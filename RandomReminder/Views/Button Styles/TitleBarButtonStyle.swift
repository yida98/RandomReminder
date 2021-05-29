//
//  TitleBarButtonStyle.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-10.
//

import Foundation
import SwiftUI

struct TitleBarButtonStyle: ButtonStyle {
    
    let bgColor: Color
    init(_ bgColor: Color = .dreamPurple) {
        self.bgColor = bgColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        MyButton(bgColor, configuration: configuration)
    }
    
    struct MyButton: View {
        let configuration: TitleBarButtonStyle.Configuration
        let bgColor: Color
        
        init(_ backgrounColor: Color = .dreamPurple, configuration: BasicButtonStyle.Configuration) {
            self.bgColor = backgrounColor
            self.configuration = configuration
        }
        
        var body: some View {
            Group {
                configuration.label
                    .frame(width: Constants.circleXS, height: Constants.circleXS)
                    .foregroundColor(Color.white)
                    .padding(5)
            }
            .background(bgColor.opacity(0.2))
            .cornerRadius(5)
            .padding(6)
            .padding(.horizontal, 10)
        }
    }
    
}
