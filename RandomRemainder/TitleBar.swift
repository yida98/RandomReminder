//
//  TitleBar.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-05.
//

import SwiftUI

struct TitleBar: View {
    
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
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
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}
