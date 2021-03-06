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
    
    @Published var snooze: Bool = false
    @Published var delete: Bool = false
    
    @ObservedObject var alarm: Alarm
    
    @Published var isPresenting: Bool = false
    @Published var showAlert: Bool = false
    
    private var cancellable = Set<AnyCancellable>()

    private var snoozePublisher: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($location)
            .map { result in
                let x = result.1.x
                return (x > AlarmTools.inset)
            }
            .eraseToAnyPublisher()
    }
    private var deletePublisher: AnyPublisher<Bool, Never> {
        return CurrentValueSubject<Bool, Never>(false)
            .combineLatest($location)
            .map { result in
                let x = result.1.x
                return (x < -AlarmTools.inset)
            }
            .eraseToAnyPublisher()
    }
    
    init(alarm: Alarm) {
        self.alarm = alarm
        snoozePublisher
            .receive(on: RunLoop.main)
            .sink { value in
                self.snooze = value
            }
            .store(in: &cancellable)
        
        deletePublisher
            .receive(on: RunLoop.main)
            .sink { value in
                self.delete = value
            }
            .store(in: &cancellable)
    }
    
    func deleteAlarmCheck() {
        showAlert = true
    }
    
    func deleteAlarm() {
        Storage.shared.deleteAlarm(with: alarm.id)
    }
    
    func snoozeAlarm() {
        alarm.snoozed.toggle()
        Storage.shared.updateAlarm(alarm, for: alarm.id)
        if alarm.snoozed {
            LocalNotificationManager.shared.snoozeAlarm(for: alarm)
        } else {
            LocalNotificationManager.shared.addNotification(alarm: alarm)
        }
    }
}

extension AlarmViewModel {
    static private let graceLength: CGFloat = 30
    static private let leftBound: CGFloat = AlarmTools.inset
    static private let rightBound: CGFloat = -AlarmTools.inset
}
