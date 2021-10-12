//
//  UserSettings.swift
//  SleepKarma
//
//  Created by John Bogil on 2/11/21.
//

import Foundation
import Combine

class LogDetailVM: ObservableObject {

    var saveLog = PassthroughSubject<Night, Never>()
    private var nights = [Night]()
    private var cancellables = Set<AnyCancellable>()

    enum State {
        case create
        case edit
    }

    init(state: State) {

        DatabaseInterface.shared.$nights
            .assign(to: \.nights, on: self)
            .store(in: &cancellables)

        saveLog
            .sink { night in
                switch state {
                case .create:
                    DatabaseInterface.shared.createNight.send(night)
                case .edit:
                    DatabaseInterface.shared.updateNight.send(night)
                }
            }
            .store(in: &cancellables)
    }
}
