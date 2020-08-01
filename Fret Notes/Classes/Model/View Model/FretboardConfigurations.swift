//
//  FretboardConfigurations.swift
//  Fret Notes
//
//  Created by luca strazzullo on 30/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct FretboardConfigurations {

    struct ConfigurationItem: Identifiable, Codable {
        let id: String = UUID().uuidString
        let frets: ClosedRange<Int>
        let title: String
    }


    // MARK: Type properties

    private static let userDefaultsKey: String = "defaultConfiguration"


    // MARK: Instance properties

    let items: [ConfigurationItem]


    // MARK: Object life cycle

    init() {
        items = [
            .init(frets: FretBoard.defaultFretsRange, title: "Full fretboard"),
            .init(frets: 0...9, title: "From 0 to 9th fret"),
            .init(frets: 7...12, title: "From 7th to 12th fret"),
            .init(frets: 12...22, title: "From 12th to 22th fret")
        ]
    }


    // MARK: Public methods

    func getDefaultConfigutation() -> ConfigurationItem {
        guard let data = UserDefaults.standard.object(forKey: FretboardConfigurations.userDefaultsKey) as? Data else {
            return items[0]
        }
        guard let configuration = try? JSONDecoder().decode(ConfigurationItem.self, from: data) else {
            return items[0]
        }
        return configuration
    }


    func save(defaultConfiguration item: ConfigurationItem) {
        if let data = try? JSONEncoder().encode(item) {
            UserDefaults.standard.setValue(data, forKey: FretboardConfigurations.userDefaultsKey)
            UserDefaults.standard.synchronize()
        }
    }
}
