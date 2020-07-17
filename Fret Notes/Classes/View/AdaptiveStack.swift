//
//  AdaptiveStack.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

class DeviceProperties: ObservableObject {

    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    init() {
        NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .compactMap { notification in
                guard let device = notification.object as? UIDevice else { return nil }
                return device.orientation
            }
            .assign(to: $orientation)
    }
}


struct AdaptiveStack<Content: View>: View {

    @StateObject private var device = DeviceProperties()

    let horizontalAlignment: HorizontalAlignment
    let verticalAlignment: VerticalAlignment
    let spacing: CGFloat?
    let content: () -> Content

    init(horizontalAlignment: HorizontalAlignment = .center, verticalAlignment: VerticalAlignment = .center, spacing: CGFloat? = nil, @ViewBuilder content: @escaping () -> Content) {
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        Group {
            if device.orientation.isLandscape {
                HStack(alignment: verticalAlignment, spacing: spacing, content: content)
            } else {
                VStack(alignment: horizontalAlignment, spacing: spacing, content: content)
            }
        }
    }
}
