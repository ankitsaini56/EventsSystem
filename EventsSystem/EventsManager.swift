//
//  EventsManager.swift
//  EventsSystem
//
//  Created by Ankit Saini on 24/05/23.
//

import Foundation

public protocol EventsManagerProtocol {
    func addEventToSystem(events: [String: String]) -> Bool
    func getAggregatedAnswer(key: String) -> [Int]
}

public class EventsManager:NSObject, EventsManagerProtocol {
    public override init() {
        super.init()
    }
    public func addEventToSystem(events: [String: String]) -> Bool {
        var keyValueArray : [EventsKeyValue] = []
        //Get saved Events memory address and size

        ///Here I have doubt that whether we should use userdefaults or local session?
        /*
         if let savedEvents = UserDefaults.standard.object(forKey: "SavedEventMemory") as? NSNumber {
            savedEventMemory = UnsafeMutablePointer<EventsKeyValue>(bitPattern: UInt(truncating: savedEvents))
        }
        (UserDefaults.standard.value(forKey: "SavedEventMemorySize") as? Int) ?? 0
         */
        let savedEventMemory : UnsafeMutablePointer<EventsKeyValue>? = Session.shared.eventAddress
        let savedEventMemorySize = Session.shared.eventSize

        for (key,value) in events {
            var cString = strdup(key)
            let event = EventsKeyValue(key: cString, value: Int32(value) ?? 0, timestamp: Int32(Date().timeIntervalSince1970))
            keyValueArray.append(event)
            cString = nil
        }

        let eventMemory = addEventsToMemory(&keyValueArray, Int32(keyValueArray.count), savedEventMemory, Int32(savedEventMemorySize))

        //Save Events memory address and size
        Session.shared.eventSize = savedEventMemorySize + events.count
        Session.shared.eventAddress = eventMemory

        //        let number = NSNumber(value: UInt(bitPattern: eventMemory))
//        UserDefaults.standard.set(number, forKey: "SavedEventMemory")
//        UserDefaults.standard.set((savedEventMemorySize + events.count), forKey: "SavedEventMemorySize")
        return eventMemory == nil ? false : true
    }

    public func getAggregatedAnswer(key: String) -> [Int] {
        var events : [Int] = []

///Here I have doubt that whether we should use userdefaults or local session?
          /*
           if let savedEvents = UserDefaults.standard.object(forKey: "SavedEventMemory") as? NSNumber {
                    savedEventMemory = UnsafeMutablePointer<EventsKeyValue>(bitPattern: UInt(truncating: savedEvents))
                }
            (UserDefaults.standard.value(forKey: "SavedEventMemorySize") as? Int) ?? 0
           */

        let savedEventMemory : UnsafeMutablePointer<EventsKeyValue>? = Session.shared.eventAddress
        let savedEventMemorySize = Session.shared.eventSize

        let cString = strdup(key)
        let tenSecondsEvent = getEventsForTime(Int32(10), Int32(Date().timeIntervalSince1970), savedEventMemory, Int32(savedEventMemorySize), cString)
        let twentySecondsEvent = getEventsForTime(Int32(20), Int32(Date().timeIntervalSince1970), savedEventMemory, Int32(savedEventMemorySize), cString)

        if tenSecondsEvent >= 0 && twentySecondsEvent >= 0 {
            events.append(Int(tenSecondsEvent))
            events.append(Int(twentySecondsEvent))
        }
        else {
            print("Error in getting events")
        }
        return events
    }

    deinit {
        Session.shared.reset()
        freeMemory()
    }

}
