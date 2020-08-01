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

    let fretboard: Fretboard

    let highlightedFret: Int
    let highlightedString: Int

    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 8) {
                ForEach(Array(fretboard.frets), id: \.self) { position in
                    self.fretView(at: position)
                    .frame(width: FretboardView.fretWidth(at: position))
                    .background(self.fretBackgroundColor(at: position))
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 100)

            VStack(alignment: .center) {
                ForEach(Array(fretboard.strings), id: \.self) { position in
                    self.stringView(at: position)
                    .frame(maxHeight: .infinity)
                }
            }
            .padding(.vertical, 32)
        }
    }


    // MARK: Private helper methods

    private func fretBackgroundColor(at position: Int) -> Color {
        return position == 0 ? Color("Fretboard.capo") : Color("Fretboard.fret")
    }


    private func fretView(at position: Int) -> some View {
        if position == highlightedFret {
            return AnyView(FretView(position: position)
            .alignmentGuide(.highlightedFret) { d in d[HorizontalAlignment.center] })
        } else {
            return AnyView(FretView(position: position))
        }
    }


    private func stringView(at position: Int) -> some View {
        if position == highlightedString {
            return AnyView(StringView(position: position)
                .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] })

        } else {
            return AnyView(StringView(position: position))
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
                    .opacity(0.8)
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

    static let fretboard6Strings = Fretboard(.standard, frets: 0...3)
    static let fretboard3Strings = Fretboard(.standard, frets: 0...3, strings: 4...6)

    static var previews: some View {
        Group {
            FretboardView(fretboard: fretboard6Strings, highlightedFret: 1, highlightedString: 6)
            .frame(height: 400)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            FretboardView(fretboard: fretboard3Strings, highlightedFret: 1, highlightedString: 6)
            .frame(height: 400)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
