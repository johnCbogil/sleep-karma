//
//  UserSettings.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
	private let encoder = JSONEncoder()
	private let decoder = JSONDecoder()

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
