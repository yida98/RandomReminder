//
//  PopoutViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-20.
//

import Foundation
import Combine

protocol PopoutViewModel: ObservableObject {
    var title: String { get set }
    var occurence: Int { get set }
    var activeAllDay: Bool { get set }
    var random: Bool { get set }
    var finished: Bool { get set }
    var validDates: Bool { get set }
    
    func done(_ completion: @escaping () -> Void)
    func addDuration()
    func delete(from index: IndexSet)
}

class PopoutViewModelParent: PopoutViewModel {
    @Published var title: String
    @Published var occurence: Int
    @Published var activeAllDay: Bool
    @Published var random: Bool
    @Published var duration: [(Date, Date)] {
        didSet {
            Just(duration.flatMap{ [$0.0, $0.1] }.isAscending())
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
        self.duration = Constants.defaultDates
        self.finished = false
        self.validDates = true
        self.somePublisher = CurrentValueSubject<Bool, Never>(false)
            .receive(on: RunLoop.main)
            .combineLatest($validDates, $title)
            .map { $0.1 && ($0.2.count > 0) }
            .assign(to: &$finished)
    }
    
    func done(_ completion: @escaping () -> Void) {  }
    
    func addDuration() {
        duration.append(contentsOf: Constants.defaultDates)
    }
    
    func delete(from index: IndexSet) {
        duration.remove(atOffsets: index)
        
        if duration.isEmpty {
            duration = Constants.defaultDates
        }
        
    }
    
}
