//
//  HomeVM.swift
//  SleepKarma
//
//  Created by John Bogil on 10/10/21.
//

import Foundation
import Combine

class HomeVM: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    @Published var nights = [Night]()

    var sleepEfficiencyScore: Int {
        // total time asleep for past 7 nights
        let totalTimeAsleep = Float(nights.reduce(0) { $0 + $1.totalMinutesAsleep })
        // total time spent in bed for past 7 nights
        let totalTimeInBed = Float(nights.reduce(0) { $0 + $1.totalMinutesInBed })

        // calculate score
        guard totalTimeAsleep > 0, totalTimeInBed > 0 else { return 0 }
        let score = (totalTimeAsleep / totalTimeInBed) * 100

        return Int(score)
    }

    init() {

        DatabaseInterface.shared.$nights
            .assign(to: \.nights, on: self)
            .store(in: &cancellables)

    }
}
