//
//  TimeConverter.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 03.072016.
//  Copyright © 2016 Antevis. All rights reserved.
//

import Foundation

class TimeConverter {
	
	init(){}
	
	static func timeStringfrom(seconds timeInSeconds: Int) -> String {
		
		let minutes: Int = timeInSeconds / 60
		let seconds: Int = timeInSeconds % 60
		let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
		
		return "\(minutes):\(secondsString)"
	}
}
