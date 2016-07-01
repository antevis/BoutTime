//: Playground - noun: a place where people can play

import UIKit

class HistoryEvent: Comparable {
	let year: Int
	let event: String
	let infoUrl: NSURL?
	
	init(year: Int, event: String, infoUrl: NSURL? = nil) {
		
		self.year = year
		self.event = event
		self.infoUrl = infoUrl
	}
}

func ==(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year == rhs.year
}

func <(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year < rhs.year
}

/////////////////////

let brexit: HistoryEvent = HistoryEvent(year: 2016, event: "GB voted to exit EU")
let wwii: HistoryEvent = HistoryEvent(year: 1939, event: "Hitler invaded Poland")

var historyEvents = [brexit, wwii]

var orderedHEvents = historyEvents.sort()

swap(&historyEvents[0], &historyEvents[1])

orderedHEvents == historyEvents






