//
//  PopoutViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-20.
//

import Foundation
import Combine

class PopoutViewModel: ObservableObject {
    @Published var title: String
    @Published var occurence: Int
    @Published var activeAllDay: Bool
    @Published var random: Bool
    @Published var duration: [(Date, Date)] {
        didSet {
            durationIndices = durationIndices
        }
    }
    @Published var durationIndices: [Int] {
        willSet {
            print("Duration: \(duration)\nDuration in Time: \(duration.flatMap { [$0.0.toTime(), $0.1.toTime()] })\nIndices: \(newValue)")
            Just(newValue.flatMap { [duration[$0].0, duration[$0].1] }.isAscending())
                .receive(on: RunLoop.main)
                .assign(to: &$validDates)
        }
    }
    
    @Published var finished: Bool
    @Published var validDates: Bool
    
    var somePublisher: Void
    
    init() {
        self.title = ""
        self.occurence = 10
        self.activeAllDay = true
        self.random = true
        self.duration = [Constants.defaultDates]
        self.durationIndices = [0]
        self.finished = false
        self.validDates = true
        self.somePublisher = CurrentValueSubject<Bool, Never>(false)
            .receive(on: RunLoop.main)
            .combineLatest($validDates, $title)
            .map { $0.1 && ($0.2.count > 0) }
            .assign(to: &$finished)
    }
    
    func done(_ completion: @escaping (Alarm) -> Void) {
        
        let alarm = Alarm(text: self.title,
                          duration: self.activeAllDay ?
                            [Time]() :
                            durationIndices.flatMap { [duration[$0].0.toTime(), duration[$0].1.toTime()] },
                          occurence: self.occurence,
                          randomFrequency: self.random)
        completion(alarm)
        
    }
    
    func addDuration() {
        duration.append(Constants.defaultDates)
        durationIndices.append(duration.count - 1)
    }
    
    func delete(from index: IndexSet) {
        durationIndices.remove(atOffsets: index)
        
        if duration.isEmpty {
            duration = [Constants.defaultDates]
        }
        
    }
    
}
