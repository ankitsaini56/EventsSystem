//
//  ViewController.swift
//  EventsSystemExample
//
//  Created by Ankit Saini on 25/05/23.
//

import UIKit
import EventsSystem

class ViewController: UIViewController {

    @IBOutlet weak var addEvents: UIButton!
    @IBOutlet weak var getEvents: UIButton!
    @IBOutlet weak var eventTestLabel: UILabel!
    var eventManager: EventsManagerProtocol?
    override func viewDidLoad() {

        super.viewDidLoad()
        eventManager = EventsManager()
    }

    @IBAction func getEventAction(_ sender: Any) {
        let events = eventManager?.getAggregatedAnswer(key: "key4")
        guard let events = events else { return }
        eventTestLabel.text = "10Sec = \(String(describing: events.first)) 20Sec = \(String(describing: events.last))"
    }
    

    @IBAction func addEventAction(_ sender: Any) {
        _ = eventManager?.addEventToSystem(events: ["key1": "1", "key2": "2", "key3": "3"])

    }
    

}

