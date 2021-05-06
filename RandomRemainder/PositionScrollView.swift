//
//  PositionScrollView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-05.
//

import Foundation
import SwiftUI

struct PositionScrollView<T: View>: View {
    
    var content: T
    
    @GestureState var isDragging: Bool = false
    @Binding var location: CGPoint
    
    @State var offset: CGFloat?
    
    let gesture: DragGesture = DragGesture()
    
    init(location: Binding<CGPoint>, @ViewBuilder content: () -> T) {
        self._location = location
        self.content = content()
    }
    
    var body: some View {
        LazyVStack {
            content
        }.offset(y: location.y)
        .simultaneousGesture(
            gesture
                .onChanged({ value in
                    offset = value.startLocation.y
                    let difference = value.location.y - value.startLocation.y
                    if difference > 0 && difference <= 40 {
                        print("upper bound")
                        location.y = (value.location.y + difference) * ((40 - difference)/40)
                    } else if difference <= 0 {
                        location.y = (value.location.y + difference) * Constants.movementScale
                    }
                })
                .onEnded({ value in
                    let difference = value.location.y - value.startLocation.y
                    if difference > 0 {
                        location.y = 0
                    }
                })
        )
    }
}
