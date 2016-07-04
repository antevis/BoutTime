//
//  HistoryModel.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 01/07/16.
//  Copyright © 2016 Antevis. All rights reserved.
//

import Foundation
import GameKit


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
	
	let events: [HistoryEvent]? =
		[
			HistoryEvent(year: 1900, event: "1900 - rthbvdhg sddds stghgfdf tyhgfdthbvdgfdf xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 2014, event: "2014 - Putin annexed Crimea and invaded Ukraine xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1902, event: "1902 - rthbvdh gfdsghgd sertghgfdf dfcxd dfdfdfdf xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1903, event: "1903 - rthbvdhgfd sghgdse rtghgfdf sdfdf sddsds sds xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1904, event: "1904 - rthbv dhgfds ghgdsert ghgfdf sdsdsdsdsdsd xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1969, event: "1969 - 1st Mission to the Moon sdcsdfsdfaas sss xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1999, event: "1999 - Euro currency xcdfdfdfa sds sssds sdsds xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1905, event: "1905 - 1st Revolution in Russia sdsfs sshkkkhrwe xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1914, event: "1914 - WWI Started sdsfdf sdfsdfs sdsdsdydsfss xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1917, event: "1917 - 2nd Revolution in Russia vfldajd sdsldkERE xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1924, event: "1924 - Lenin has died sfdf sddfncncsvx xss sddss s xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1939, event: "1939 - WWII started fvjs;fwl abra cadabla trax tbli xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1989, event: "1989 - Berlin wall fell gyelef lsdlvnsl;l efkcslfh xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1953, event: "1953 - Stalin died klvklvsf llf,smamf sldlfkdkfjm l xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1945, event: "1945 - WWII ended vlsflm;OE. LSDFdlfklmwwm lkfdlfdk xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1961, event: "1961 - 1st human in space fldkskm llkkfjy vlslkkej d xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1968, event: "1968 - Russians invaded CZ vvlmmle lmlslkhfsx dlkfdd xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1985, event: "1985 - Perestroika started in Russia lmleovl ljgswe c xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 1991, event: "1991 - Soviet Union collapsed klmelyvlmhslyvslhsellms xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 2000, event: "2000 - lmlhs;llamld lkjudlww mlosdmsldf lflkf yflsfsm xxx", infoUrl: "https://www.google.com"),
			HistoryEvent(year: 2016, event: "2016 - the UK voted to leave the EU llwels;lam lsdkf xxx", infoUrl: "https://www.google.com"),
		]
	
	func shuffledEventArrayOf(thisNumberOfEvents eventCount: Int) -> [HistoryEvent]? {
		
		guard let events = events else {
			
			return nil
		}
		
		let eventCount = min(eventCount, events.count)
		
		//Shuffle events
		guard let randomOrderedEvents = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(events) as? [HistoryEvent] where eventCount > 0 else {
			
			return nil
		}
		
		//return a HistoryEvent-cast slice of eventCount events (particulary, 4)
		return [HistoryEvent](randomOrderedEvents[0..<eventCount])
	}
	
	
}