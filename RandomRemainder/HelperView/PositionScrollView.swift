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
    let axes: Axis.Set
    let showIndicators: Bool
    let offsetChanged: (CGPoint) -> Void
    
    init(axes: Axis.Set = .vertical,
         showIndicators: Bool = true,
         offsetChanged: @escaping ((CGPoint) -> Void) = { _ in },
         @ViewBuilder content: () -> T) {
        self.axes = axes
        self.showIndicators = showIndicators
        self.offsetChanged = offsetChanged
        self.content = content()
    }
    
    var body: some View {
        ScrollView(axes, showsIndicators: showIndicators) {
            GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: OffsetPreferenceKey.self,
                        value: geometry.frame(in: .named("scrollView")).origin
                    )
            }
            content
        }.onPreferenceChange(OffsetPreferenceKey.self, perform: offsetChanged)
    }
    
}

struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}
