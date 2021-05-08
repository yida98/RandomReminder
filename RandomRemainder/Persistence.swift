//
//  Persistence.swift
//  RandomRemainder
//
//  Created by Yida Zhang on 2021-05-02.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: UserDefault.Keys
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    init(_ key: UserDefault.Keys, defaultValue: Value) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: Value {
        get {
            let obj = container.object(forKey: key.rawValue)
            if let valueObj = obj as? Value {
                return valueObj
            } else if let dataObj = obj as? Data {
                do {
                    return try JSONDecoder().decode(Value.self, from: dataObj)
                } catch {
                    debugPrint("\(error) \(defaultValue)")
                }
            }
            return defaultValue
        }
        set {
            if let _ = newValue as? PropertyListValue {
                container.setValue(newValue, forKey: key.rawValue)
            } else {
                let jsonData = try! JSONEncoder().encode(newValue)
                container.setValue(jsonData, forKey: key.rawValue)
            }
        }
    }
    
    enum Keys: String {
        case alarms = "alarms"
    }
}

final class Storage: ObservableObject {
    
    static let shared = Storage()
    
    var objectWillChange = PassthroughSubject<Void, Never>()
    
    @UserDefault(.alarms, defaultValue: [Alarm]())
    var alarms: [Alarm] {
        willSet {
            objectWillChange.send()
        }
    }
    
    func deleteAlarm(with id: UUID) {
        let index = alarms.firstIndex { $0.id == id }
        if index != nil {
            alarms.remove(at: index!)
        }
    }
    
    func addAlarm(alarm: Alarm) {
        alarms.append(alarm)
    }
    
    func updateAlarm(_ alarm: Alarm, for id: UUID) {
        Storage.shared.alarms = Storage.shared.alarms.map {
            if $0.id == id {
                $0.text = alarm.text
                $0.duration = alarm.duration
                $0.occurence = alarm.occurence
                $0.randomFrequency = alarm.randomFrequency
            }
            return $0
        }
    }
}

protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

