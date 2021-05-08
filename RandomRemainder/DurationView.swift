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
            DatePicker("from", selection: $viewModel.duration[index], displayedComponents: [.hourAndMinute])
                .labelsHidden()
            Spacer()
            Text("to")
            Spacer()
            DatePicker("to", selection: $viewModel.duration[index + 1], displayedComponents: [.hourAndMinute])
                .labelsHidden()
        }
    }
}

extension Date {
    static func toNearestHour(from date: Date, lowerBound: Bool) -> Date {
        var dateComponent = Calendar.current.dateComponents([.hour, .minute], from: date)
        if !lowerBound {
            dateComponent.hour = dateComponent.hour!.advanced(by: 1)
        }
        dateComponent.minute = 0
        let newDate = Calendar.current.date(from: dateComponent)
        return newDate!
    }
}
