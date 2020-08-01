//
//  FretboardIndicatorView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct FretboardIndicatorView: View {

    let fretboard: Fretboard
    let question: Question

    @State private var fretboardOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .highlightedFret, vertical: .highlightedString)) {
            FretboardView(fretboard: fretboard, highlightedFret: question.fret, highlightedString: question.string)
            IndicatorView()
        }
        .alignmentGuide(.highlightedFret) { dimension in
            dimension[.highlightedFret] + self.fretboardOffset
        }
        .frame(minHeight: 260, alignment: Alignment(horizontal: .highlightedFret, vertical: .center))
        .gesture(DragGesture().onChanged { value in
            self.fretboardOffset = -value.translation.width
        }.onEnded { _ in
            self.fretboardOffset = 0
        })
    }
}


struct IndicatorView: View {

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color("FretboardIndicator.indicator"))
                .frame(width: 24, height: 24, alignment: .center)
                .shadow(color: Color.black.opacity(colorScheme == .dark ? 1 : 0.2), radius: 2)

            Circle()
                .foregroundColor(Color("FretboardIndicator.indicator"))
                .frame(width: 32, height: 32, alignment: .center)
                .opacity(0.2)
        }
    }
}
