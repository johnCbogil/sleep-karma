//
//  DatabaseInterface.swift
//  SleepKarma
//
//  Created by John Bogil on 10/10/21.
//

import Foundation
import Combine

class DatabaseInterface {

    static let shared = DatabaseInterface()
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()
    @Published var nights = [Night]()
    let updateNight = PassthroughSubject<Night, Never>()
    let createNight = PassthroughSubject<Night, Never>()
    
    init() {
        setupBindings()

        if let nightsData = UserDefaults.standard.object(forKey: "nights") as? Data {
            if let nights = try? decoder.decode([Night].self, from: nightsData) {
                self.nights = nights
                return
            }
        }
    }

    func setupBindings() {
        $nights
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
              guard let self = self else { return }
                if let encoded = try? self.encoder.encode(self.nights) {
                    UserDefaults.standard.set(encoded, forKey: "nights")
                }
            }
            .store(in: &cancellables)

        updateNight
            .sink { [weak self] night in
                guard let self = self else { return }

                if let index = self.nights.firstIndex(where: { $0.identifier == night.identifier}) {
                    self.nights[index] = night
                }
            }
            .store(in: &cancellables)

        createNight
            .sink { [weak self] night in
                guard let self = self else { return }
                self.nights.append(night)
            }
            .store(in: &cancellables)
    }
}
