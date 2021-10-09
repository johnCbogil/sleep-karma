//
//  UserSettings.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import Foundation
import Combine

class HomeVM: ObservableObject {
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()
	
	var sleepEfficiencyScore: Int {
		
		// total time asleep for past 7 nights
		let totalTimeAsleep = Float(nights.reduce(0) { $0 + $1.totalMinutesAsleep })
		// total time spentin bed for past 7 nights
		let totalTimeInBed = Float(nights.reduce(0) { $0 + $1.totalMinutesInBed })
		
		// calculate score
		guard totalTimeAsleep > 0, totalTimeInBed > 0 else { return 0 }
		let score = (totalTimeAsleep / totalTimeInBed) * 100
		
		return Int(score)
	}
	
	@Published var nights: [Night] {
		didSet {
			if let encoded = try? encoder.encode(nights) {
				UserDefaults.standard.set(encoded, forKey: "nights")
			}
		}
	}
	
	init() {
		if let nightsData = UserDefaults.standard.object(forKey: "nights") as? Data {
			if let nights = try? decoder.decode([Night].self, from: nightsData) {
				self.nights = nights
				return
			}
		}
		self.nights = [Night]()
	}
}
