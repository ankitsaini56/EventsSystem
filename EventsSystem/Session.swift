//
//  Session.swift
//  EventsSystem
//
//  Created by Ankit Saini on 12/06/23.
//

import Foundation

final class Session {
    static let shared: Session = .init()
    var eventSize = 0
    var eventAddress: UnsafeMutablePointer<EventsKeyValue>?

    private init() {
    }

    func reset() {
        eventSize = 0
        eventAddress = nil
    }
}
