//
//  TimeConverter.swift
//  BoutTime
//
//  Created by Ivan Kazakov on 03.072016.
//  Copyright © 2016 Antevis. All rights reserved.
//

import Foundation


//just for fun
class TimeConverter {
	
	init(){}
	
	static func timeStringfrom(timeInSeconds: Int) -> String {
		
		let minutes: Int = timeInSeconds / 60
		let seconds: Int = timeInSeconds % 60
		let secondsString = seconds < 10 ? "0\(seconds)" : "\(seconds)"
		
		return "\(minutes):\(secondsString)"
	}
}
