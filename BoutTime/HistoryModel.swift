//
//  HistoryModel.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 01/07/16.
//  Copyright © 2016 Antevis. All rights reserved.
//

import Foundation

class HistoryEvent: Comparable {
	let year: Int
	let event: String
	let urlString: String?
	
	init(year: Int, event: String, infoUrl: String? = nil) {
		
		self.year = year
		self.event = event
		self.urlString = infoUrl
	}
}

//Still confused about why these funcs should be implemented outside the class definition.
func ==(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year == rhs.year
}

func <(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year < rhs.year
}

struct HistoryModel {
	
	let events: [HistoryEvent] = [
		HistoryEvent(year: 1900, event: "1900", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 2014, event: "2014 - Putin annexed Crimea and invaded Ukraine", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1902, event: "1902", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1903, event: "1903", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1904, event: "1904", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1969, event: "1969 - 1st Mission to the Moon", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1999, event: "1999 - Euro currency", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1905, event: "1905 - 1st Revolution in Russia", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1914, event: "1914 - WWI Started", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1917, event: "1917 - 2nd Revolution in Russia", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1924, event: "1924 - Lenin has died", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1939, event: "1939 - WWII started", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1989, event: "1989 - Berlin wall fell", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1953, event: "1953 - Stalin died", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1945, event: "1945 - WWII ended", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1961, event: "1961 - 1st human in space", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1968, event: "1968 - Russians invaded CZ", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1985, event: "1985 - Perestroika started in Russia", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 1991, event: "1991 - Soviet Union collapsed", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 2000, event: "2000", infoUrl: "https://teamtreehouse.com/"),
		HistoryEvent(year: 2016, event: "2016 - the UK voted to leave the EU", infoUrl: "https://teamtreehouse.com/"),
	]
}