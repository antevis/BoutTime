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
	let infoUrl: NSURL?
	
	init(year: Int, event: String, infoUrl: NSURL? = nil) {
		
		self.year = year
		self.event = event
		self.infoUrl = infoUrl
	}
}

//Still confused about why these funcs should be implemented outside the class definition.
func ==(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year == rhs.year
}

func <(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.year < rhs.year
}

