//
//  DurationView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import SwiftUI

struct DurationView<T: PopoutViewModel>: View {
    @EnvironmentObject var viewModel: T
    var index: Int
    var body: some View {
        HStack {
            DatePicker("from", selection: $viewModel.duration[index].0, displayedComponents: [.hourAndMinute])
                .labelsHidden()
            Spacer()
            Text("to")
            Spacer()
            DatePicker("to", selection: $viewModel.duration[index].1, displayedComponents: [.hourAndMinute])
                .labelsHidden()
        }
    }
}
