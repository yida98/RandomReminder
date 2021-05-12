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
    init(_ bgColor: Color = .lightGrey3) {
        self.bgColor = bgColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        MyButton(bgColor, configuration: configuration)
    }
    
    struct MyButton: View {
        let configuration: TitleBarButtonStyle.Configuration
        let bgColor: Color
        
        init(_ backgrounColor: Color = .lightGrey3, configuration: BasicButtonStyle.Configuration) {
            self.bgColor = backgrounColor
            self.configuration = configuration
        }
        
        var body: some View {
            configuration.label
                .frame(width: Constants.circleXS, height: Constants.circleXS)
                .foregroundColor(Color.white)
                .padding()
                .padding(.horizontal, 10)
        }
    }
    
}
