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
            HStack(alignment: .center, spacing: 8) {
                ForEach(frets(), id: \.self) { position in
                    FretView(position: position)
                }
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .center, spacing: 40) {
                ForEach(strings(), id: \.self) { position in
                    StringView(position: position, isHighlighted: position == self.highlightedString)
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

    private static let gauges: [CGFloat] = [2, 2.2, 2.8, 3.4, 4.2, 5]

    let position: Int
    let isHighlighted: Bool

    var body: some View {
        if isHighlighted {
            return AnyView(
                Rectangle()
                    .foregroundColor(Color("Fretboard.string"))
                    .frame(height: gauge(at: position), alignment: .center)
                    .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
            )
        } else {
            return AnyView(
                Rectangle()
                    .foregroundColor(Color("Fretboard.string"))
                    .frame(height: gauge(at: position), alignment: .center)
            )
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
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .foregroundColor(Color("Fretboard.capo"))
                        .frame(maxWidth: 4)
                }
            } else {
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .foregroundColor(Color("Fretboard.fret"))

                VStack {
                    Spacer()
                    Text("\(position)")
                        .fontWeight(.bold)
                        .opacity(0.2)
                        .padding(.bottom, 12)
                }
            }

            if hasSingleMarker() {
                Circle()
                    .frame(width: 12, height: 12, alignment: .center)
                    .foregroundColor(Color("Fretboard.marker"))
            } else if hasDoubleMarker() {
                VStack(alignment: .center, spacing: 80) {
                    Circle().frame(width: 12, height: 12, alignment: .center)
                    Circle().frame(width: 12, height: 12, alignment: .center)
                }
                .foregroundColor(Color("Fretboard.marker"))
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
        FretboardView(fretboard: fretboard, middleFret: 2, highlightedString: 1)
            .preferredColorScheme(.dark)
    }
}
