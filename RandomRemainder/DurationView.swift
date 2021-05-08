//
//  DurationView.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import SwiftUI

struct DurationView: View {
    @EnvironmentObject var viewModel: CreateAlarmViewModel
    @State var from: Date = Date.toNearestHour(from: Date(), lowerBound: true)
    @State var to: Date = Date.toNearestHour(from: Date(), lowerBound: false)
    var body: some View {
        HStack {
            DatePicker("from", selection: $from, displayedComponents: [.hourAndMinute])
                .labelsHidden()
            Spacer()
            Text("to")
            Spacer()
            DatePicker("to", selection: $to, displayedComponents: [.hourAndMinute])
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

struct DurationView_Previews: PreviewProvider {
    static var previews: some View {
        DurationView()
    }
}
