//
//  EventsSystemTests.swift
//  EventsSystemTests
//
//  Created by Ankit Saini on 23/05/23.
//

import XCTest
@testable import EventsSystem

final class EventsSystemTests: XCTestCase {
    var eventSystem: EventsManagerProtocol!


    override func setUpWithError() throws {
        eventSystem = EventsManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Session.shared.reset()
        eventSystem = nil
    }

    func testAddEvent1() {
        XCTAssertTrue(eventSystem.addEventToSystem(events: ["key1": "1", "key2": "2", "key3": "3"]))
    }

    func testGetEvent() {
        _ = eventSystem.addEventToSystem(events: ["key1": "1", "key2": "2", "key3": "3"])
        XCTAssertEqual(eventSystem.getAggregatedAnswer(key: "key1"), [1,1])
    }

    func testGetEventWhenWrongKey() {
        XCTAssertEqual(eventSystem.getAggregatedAnswer(key: "key4"), [])
    }


    func testGetEventWhenNoEventsAdded() {
        XCTAssertEqual(eventSystem.getAggregatedAnswer(key: "key1"), [])
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    

}
