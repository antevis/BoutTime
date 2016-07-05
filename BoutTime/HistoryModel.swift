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
	let queueIndex: Int
	var event: String
	let hint: String?
	let urlString: String?
	
	init(queueIndex: Int, event: String, hint: String? = nil, infoUrl: String? = nil) {
		
		self.queueIndex = queueIndex
		self.event = event
		self.hint = hint
		self.urlString = infoUrl
	}
}

//Still confused about why these funcs should be implemented outside the class definition.
func ==(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.queueIndex == rhs.queueIndex
}

func <(lhs: HistoryEvent, rhs: HistoryEvent) -> Bool {
	
	return lhs.queueIndex < rhs.queueIndex
}

struct HistoryModel {
	
	let events: [HistoryEvent]? =
		[
			HistoryEvent(queueIndex: 0, event: "Proconsul", hint: "18 - 15 Ma", infoUrl: "https://en.wikipedia.org/wiki/Proconsul_(primate)"),
			HistoryEvent(queueIndex: 1, event: "Nakalipithecus nakayamai", hint: "9.9 - 9.8 Ma", infoUrl: "https://en.wikipedia.org/wiki/Nakalipithecus"),
			HistoryEvent(queueIndex: 2, event: "Sahelanthropus tchadensis", hint: "7 - 6.2 Ma", infoUrl: "https://en.wikipedia.org/wiki/Sahelanthropus"),
			HistoryEvent(queueIndex: 3, event: "Orrorin tugenensis", hint: "6.2 - 5.8 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/orrorin-tugenensis"),
			HistoryEvent(queueIndex: 4, event: "Ardipithecus kadabba", hint: "5.8 - 5.2 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/ardipithecus-ramidus"),
			HistoryEvent(queueIndex: 5, event: "Ardipithecus ramidus", hint: "4.4 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/ardipithecus-ramidus"),
			HistoryEvent(queueIndex: 6, event: "Australopithecus anamensis", hint: "4.2 - 3.9 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/australopithecus-anamensis"),
			HistoryEvent(queueIndex: 7, event: "Kenyanthropus platyops", hint: "3.5 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/kenyanthropus-platyops"),
			HistoryEvent(queueIndex: 8, event: "Australopithecus bahrelghazali", hint: "3.5 - 3.0 Ma", infoUrl: "https://en.wikipedia.org/wiki/Australopithecus_bahrelghazali"),
			HistoryEvent(queueIndex: 9, event: "Australopithecus afarensis", hint: "3.85 - 2.95 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/australopithecus-afarensis"),
			HistoryEvent(queueIndex: 10, event: "Australopithecus garhi", hint: "2.5 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/australopithecus-garhi"),
			HistoryEvent(queueIndex: 11, event: "Paranthropus aethiopicus", hint: "2.7 - 2.3 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/paranthropus-aethiopicus"),
			HistoryEvent(queueIndex: 12, event: "Australopithecus africanus", hint: "3.2 - 2.1 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/australopithecus-africanus"),
			HistoryEvent(queueIndex: 13, event: "Homo rudolfensis", hint: "1.9 - 1.8 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-rudolfensis"),
			HistoryEvent(queueIndex: 14, event: "Australopithecus sediba", hint: "1.977 - 1.98 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/australopithecus-sediba"),
			HistoryEvent(queueIndex: 15, event: "Homo habilis", hint: "2.4 - 1.4 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-habilis"),
			HistoryEvent(queueIndex: 16, event: "Homo ergaster", hint: "1.9 - 1.3 Ma", infoUrl: "https://en.wikipedia.org/wiki/Homo_ergaster"),
			HistoryEvent(queueIndex: 17, event: "Homo georgicus", hint: "1.85 - 1.77 Ma", infoUrl: "https://en.wikipedia.org/wiki/Homo_erectus#Homo_erectus_georgicus"),
			HistoryEvent(queueIndex: 18, event: "Paranthropus robustus", hint: "1.8 - 1.2 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/paranthropus-robustus"),
			HistoryEvent(queueIndex: 19, event: "Paranthropus boisei", hint: "2.3 - 1.2 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/paranthropus-boisei"),
			HistoryEvent(queueIndex: 20, event: "Homo heidelbergensis", hint: "600 - 200 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-heidelbergensis"),
			HistoryEvent(queueIndex: 21, event: "Homo erectus", hint: "1.89 - 0.143 Ma", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-erectus"),
			HistoryEvent(queueIndex: 22, event: "Homo floresiensis", hint: "190 - 50 Ka", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-floresiensis"),
			HistoryEvent(queueIndex: 23, event: "Homo neanderthalensis", hint: "400 - 40 Ka", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-neanderthalensis"),
			HistoryEvent(queueIndex: 24, event: "Homo helmei", hint: "260 Ka", infoUrl: "https://en.wikipedia.org/wiki/Florisbad_Skull"),
			HistoryEvent(queueIndex: 25, event: "Homo sapiens", hint: "200 Ka - present", infoUrl: "http://humanorigins.si.edu/evidence/human-fossils/species/homo-sapiens"),
		]
	
	func shuffledEventArrayOf(thisNumberOfEvents eventCount: Int) -> [HistoryEvent]? {
		
		guard let events = events where events.count > 0 && events.count >= eventCount else {
			
			return nil
		}
		
		//let eventCount = min(eventCount, events.count)
		
		//Shuffle events
		guard let randomOrderedEvents = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(events) as? [HistoryEvent] /*where eventCount > 0*/ else {
			
			return nil
		}
		
		//return a HistoryEvent-cast slice of eventCount events (particulary, 4)
		return [HistoryEvent](randomOrderedEvents[0..<eventCount])
	}
	
	
}