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
                .stroke(Constants.borderColour, lineWidth: 1)
                .background(DrippingShape(location: viewModel.location)
                                .foregroundColor(Constants.highlightColour))
                .frame(height: Constants.navBarHeight)
            Image("cat")
                .resizable()
                .foregroundColor(Constants.highlightColour)
                .frame(width: Constants.circleL, height: Constants.circleL)
                .offset(y: Constants.navBarHeight + 30)
                .mask(
                    DrippingShape(location: viewModel.location)
                        .fill(Constants.highlightColour)
                        .frame(height: Constants.navBarHeight)
                )
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button {
                        viewModel.isPresenting.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                        
                    }.buttonStyle(TitleBarButtonStyle())
                }

            }.frame(height: Constants.navBarHeight)
        }
    }
}

struct TitleBar_Previews: PreviewProvider {
    static var previews: some View {
        TitleBar()
    }
}
