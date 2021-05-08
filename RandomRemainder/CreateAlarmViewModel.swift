//
//  CreateAlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-07.
//

import Foundation

class CreateAlarmViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var occurence: Int = 3
    @Published var activeAllDay: Bool = true
    @Published var random: Bool = true
    @Published var duration: [Date] = [Date()]
    
    @Published var finished: Bool = false
    
    func done() {
        
    }
    
    func addDuration() {
        duration.append(Date())
    }
}
