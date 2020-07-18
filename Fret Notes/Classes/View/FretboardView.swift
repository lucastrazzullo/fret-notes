//
//  FretboardView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

extension VerticalAlignment {

    struct StringAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[VerticalAlignment.center]
        }
    }

    static let highlightedString = VerticalAlignment(StringAlignment.self)
}


struct FretboardView: View {

    let fretboard: FretBoard

    let middleFret: Int
    let highlightedString: Int

    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 12) {
                ForEach(frets(), id: \.self) { position in
                    FretView(position: position)
                }
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .center, spacing: 40) {
                ForEach(strings(), id: \.self) { position in
                    StringView(position: position, isHighlighted: position == highlightedString)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }


    // MARK: Private helper methods

    private func strings() -> [Int] {
        return Array(fretboard.strings)
    }


    private func frets() -> [Int] {
        return Array(middleFret-2...middleFret+2)
    }
}


struct StringView: View {

    private static let gauges: [CGFloat] = [1, 1.2, 1.8, 2.4, 3.2, 4]

    let position: Int
    let isHighlighted: Bool

    var body: some View {
        if isHighlighted {
            Rectangle()
                .frame(height: gauge(at: position), alignment: .center)
                .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
        } else {
            Rectangle()
                .frame(height: gauge(at: position), alignment: .center)
        }
    }


    // MARK: Private helper methods

    private func gauge(at position: Int) -> CGFloat {
        return StringView.gauges[position - 1]
    }
}


struct FretView: View {

    private static let singleMarkPositions: Set<Int> = [3, 5, 7, 9, 15, 17, 19, 21]
    private static let doubleMarkPositions: Set<Int> = [12, 24]

    let position: Int

    var body: some View {
        ZStack {
            if position < 0 {
                Rectangle().foregroundColor(.clear)
            } else if position == 0 {
                ZStack {
                    Rectangle().foregroundColor(.clear)
                    Rectangle().foregroundColor(.gray).frame(maxWidth: 4)
                }
            } else {
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(position >= 0 ? 0.1 : 0)
            }

            if hasSingleMarker() {
                Circle().frame(width: 12, height: 12, alignment: .center)
            } else if hasDoubleMarker() {
                VStack(alignment: .center, spacing: 80) {
                    Circle().frame(width: 12, height: 12, alignment: .center)
                    Circle().frame(width: 12, height: 12, alignment: .center)
                }
            } else if position > 0 {
                Text("\(position)").fontWeight(.bold).opacity(0.4)
            }
        }
    }


    // MARK: Private helper methods

    private func hasSingleMarker() -> Bool {
        return FretView.singleMarkPositions.contains(position)
    }


    private func hasDoubleMarker() -> Bool {
        return FretView.doubleMarkPositions.contains(position)
    }
}


struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        let fretboard = FretBoard(tuningType: .standard)
        FretboardView(fretboard: fretboard, middleFret: 12, highlightedString: 1)
    }
}
