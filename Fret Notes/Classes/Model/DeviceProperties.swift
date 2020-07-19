//
//  DeviceProperties.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI
import Combine

class DeviceProperties: ObservableObject {

    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    private var subscriptions: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { notification -> UIDeviceOrientation? in
                guard let device = notification.object as? UIDevice else { return nil }
                return device.orientation
            }
            .assign(to: \.orientation, on: self)
            .store(in: &subscriptions)
    }
}
