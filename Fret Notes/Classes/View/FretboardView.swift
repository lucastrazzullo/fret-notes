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
        switch position {
        case 1:
            return 1
        case 2:
            return 1.2
        case 3:
            return 1.8
        case 4:
            return 2.4
        case 5:
            return 3.2
        case 6:
            return 4
        default:
            return 1
        }
    }
}


struct FretView: View {

    private static let markPositions: Set<Int> = [3, 5, 7, 9, 12, 15, 17, 19]

    let position: Int

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .opacity(exists() ? 0.1 : 0)

            if hasMarker() {
                Circle().frame(width: 12, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }


    // MARK: Private helper methods

    private func hasMarker() -> Bool {
        return FretView.markPositions.contains(position)
    }


    private func exists() -> Bool {
        return position > 0
    }
}


struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        let fretboard = FretBoard(tuningType: .standard)
        FretboardView(fretboard: fretboard, middleFret: 2, highlightedString: 1)
    }
}
