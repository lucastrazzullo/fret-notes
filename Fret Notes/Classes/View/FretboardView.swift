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


extension HorizontalAlignment {

    struct FretAlignment: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[HorizontalAlignment.center]
        }
    }

    static let highlightedFret = HorizontalAlignment(FretAlignment.self)
}


struct FretboardView: View {

    let fretboard: FretBoard

    let highlightedFret: Int
    let highlightedString: Int

    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 8) {
                ForEach(Array(fretboard.frets), id: \.self) { position in
                    self.fretView(at: position)
                }
            }
            .padding(.horizontal, 100)

            VStack(alignment: .center) {
                ForEach(Array(fretboard.strings), id: \.self) { position in
                    self.stringView(at: position)
                }
            }
            .padding(.vertical, 28)
        }
    }


    // MARK: Private helper methods

    private func fretBackgroundColor(at position: Int) -> Color {
        return position == 0 ? Color("Fretboard.capo") : Color("Fretboard.fret")
    }


    private func fretView(at position: Int) -> some View {
        if position == highlightedFret {
            return AnyView(FretView(position: position)
            .alignmentGuide(.highlightedFret) { d in d[HorizontalAlignment.center] }
            .frame(width: FretboardView.fretWidth(at: position))
            .background(fretBackgroundColor(at: position).edgesIgnoringSafeArea(.all)))
        } else {
            return AnyView(FretView(position: position)
            .frame(width: FretboardView.fretWidth(at: position))
            .background(fretBackgroundColor(at: position).edgesIgnoringSafeArea(.all)))
        }
    }


    private func stringView(at position: Int) -> some View {
        if position == highlightedString {
            return AnyView(StringView(position: position)
                .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
                .frame(maxHeight: .infinity))

        } else {
            return AnyView(StringView(position: position)
                .frame(maxHeight: .infinity))
        }
    }


    // MARK: Type methods

    static func fretWidth(at position: Int) -> CGFloat {
        switch position {
        case 0:
            return 16
        case 1...7:
            return 100
        case 8...12:
            return 80
        case 13...15:
            return 60
        default:
            return 50
        }
    }
}


struct FretView: View {

    private static let singleMarkPositions: Set<Int> = [3, 5, 7, 9, 15, 17, 19, 21]
    private static let doubleMarkPositions: Set<Int> = [12, 24]

    let position: Int

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("\(position)")
                    .font(.footnote)
                    .opacity(0.2)
                    .padding(.bottom, 8)
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


struct StringView: View {

    private static let gauges: [CGFloat] = [2, 2.2, 2.8, 3.4, 4.2, 5]

    let position: Int

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("Fretboard.string"))
                .frame(height: gauge(at: position), alignment: .center)
        }
    }


    // MARK: Private helper methods

    private func gauge(at position: Int) -> CGFloat {
        return StringView.gauges[position - 1]
    }
}


struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        let fretboard = FretBoard(tuningType: .standard)
        return FretboardView(fretboard: fretboard, highlightedFret: 1, highlightedString: 1)
            .preferredColorScheme(.dark)
    }
}
