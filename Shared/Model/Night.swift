//
//  Night.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import Foundation

struct Night: Codable, Hashable {
	let targetSleepTime: Date
	let targetWakeUpTime: Date
	let bedTime: Date
	let fellAsleepTime: Date
	let awakeNightTime: String
	let wakeUpTime: Date
	let outOfBedTime: Date
	var date = Date().previousDay()
	var totalMinutesAsleep: Int {
		let timeDifferenceMinutes = Date().minutesBetween(date1: fellAsleepTime, date2: wakeUpTime)
		return timeDifferenceMinutes - (Int(awakeNightTime) ?? 0)
	}
	var totalMinutesInBed: Int {
		let total = Date().minutesBetween(date1: bedTime, date2: outOfBedTime)
		return total
	}
}
