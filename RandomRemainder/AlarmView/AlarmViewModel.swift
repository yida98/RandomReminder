//
//  AlarmViewModel.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-04.
//

import Foundation
import SwiftUI
import Combine

class AlarmViewModel: ObservableObject {
    
    @Published var location: CGPoint = CGPoint(x: 0, y: 0)
    @Published var difference: CGFloat?
    @Published var finished: Bool = false
    
    static private var graceLength: CGFloat = 30
    static private var firstBound: CGFloat = -(Constants.insetSize.width/2 + AlarmTools.padding + AlarmViewModel.graceLength)
    static private var secondBound: CGFloat = -(-AlarmViewModel.firstBound + AlarmTools.spaceBetween + AlarmViewModel.graceLength)
    
    @Published var snooze: Bool = false
    @Published var delete: Bool = false
    
    private var cancellable = Set<AnyCancellable>()

    private var snoozePublisher: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($location)
            .map { result in
                let x = result.1.x
                return (x < AlarmViewModel.firstBound && x > AlarmViewModel.secondBound)
            }
            .eraseToAnyPublisher()
    }
    private var deletePublisher: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($location)
            .map { result in
                let x = result.1.x
                return (x < AlarmViewModel.secondBound)
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        snoozePublisher
            .receive(on: RunLoop.main)
            .sink { value in
                if value == true {
                    self.snoozeAlarm()
                }
                self.snooze = value
            }
            .store(in: &cancellable)
        
        deletePublisher
            .receive(on: RunLoop.main)
            .sink { value in
                if value == true {
                    self.deleteAlarm()
                }
                self.delete = value
            }
            .store(in: &cancellable)
    }
    
    func deleteAlarm() {
        debugPrint("Delete")
    }
    
    func snoozeAlarm() {
        debugPrint("Snooze")
    }
}
