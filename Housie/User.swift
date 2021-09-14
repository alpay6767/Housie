//
//  User.swift
//  Housie
//
//  Created by Alpay Kücük on 03.08.21.
//

import Foundation
import UIKit
import DefaultsKit

class User {
    
    var id: String?
    var coins: Int?
    var listOfHouses = [House]()
    var listOfUnlockedHouses = [String]()
    var costsOfUnlockedHouses = [Int]()
    var eventslist = [Event]()
    
    init(id: String, coins: Int) {
        self.id = id
        self.coins = coins
    }
    
    func addOrUpdateEvent(additionaltime: Int, additionalpayment: Int, date: String) {
        var found = false
        
        for currentevent in eventslist {
            if currentevent.date == date {
                found = true
                
                currentevent.spendtime = currentevent.spendtime + additionaltime
                currentevent.payedloan = currentevent.payedloan + additionalpayment
                break
            }
        }
        
        if !found {
            var newevent = Event(date: date, payedloan: additionalpayment, spendtime: additionaltime)
            eventslist.append(newevent)
        }
        
        let defaults = Defaults()
        let key = Key<[Event]>("ereignisse")

        defaults.set(eventslist, for: key)
    }
    
    
    func getEventFromEventslist(eventstring: String) -> Event {
        for event in eventslist {
            if event.date == eventstring {
                return event
            }
        }
        return Event(date: "", payedloan: 0, spendtime: 0)
    }
    
    
}
