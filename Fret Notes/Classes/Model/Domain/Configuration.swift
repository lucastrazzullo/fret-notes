//
//  Configuration.swift
//  Fret Notes
//
//  Created by luca strazzullo on 30/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import Foundation

struct Configuration: Codable {

    enum Default: Int, CaseIterable {
        case full
        case startBoard
        case middleBoard
        case endBoard

        var fretboard: Fretboard {
            switch self {
            case .full:
                return Fretboard(.standard)
            case .startBoard:
                return Fretboard(.standard, frets: 0...9)
            case .middleBoard:
                return Fretboard(.standard, frets: 7...12)
            case .endBoard:
                return Fretboard(.standard, frets: 12...22)
            }
        }
    }


    // MARK: Type properties

    private static let userDefaultsKey: String = "configuration"


    // MARK: Instance properties

    let fretboard: Fretboard


    // MARK: Object life cycle

    init(fretboard: Fretboard) {
        self.fretboard = fretboard
    }


    init(with default: Default = Default.full) {
        self.init(fretboard: `default`.fretboard)
    }


    // MARK: Public methods

    static func stored() -> Configuration? {
        guard let data = UserDefaults.standard.object(forKey: Configuration.userDefaultsKey) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(Configuration.self, from: data)
    }


    func store() {
        if let data = try? JSONEncoder().encode(self) {
            UserDefaults.standard.setValue(data, forKey: Configuration.userDefaultsKey)
            UserDefaults.standard.synchronize()
        }
    }
}
