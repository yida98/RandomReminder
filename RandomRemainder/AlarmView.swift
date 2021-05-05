//
//  AlarmView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-03.
//

import SwiftUI

struct AlarmView: View {
    
    var alarm: Alarm
    
    @GestureState private var isDragging: Bool = false
    @State private var x: CGFloat = 0
    @State private var difference: CGFloat?
    
    var body: some View {
        ZStack {
            AlarmTools(xValue: $x)
            Group {
                VStack(alignment: .leading) {
                    Text(alarm.descriptionBuilder())
                    Text(alarm.text)
                }
                .modifier(AlarmViewModifier())
            }
            .offset(x: x)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        if difference == nil {
                            difference = value.location.x - x
                        }
                        x += value.location.x - difference!
                        x = x * Constants.movementScale
                    })
                    .onEnded({ value in
                        difference = nil
                        x = 0
                    })
            )
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView(alarm: Alarm(text: "Wub"))
    }
}
