//
//  FretboardIndicatorView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct FretboardIndicatorView: View {

    @EnvironmentObject var challenge: Challenge

    @State private var fretboardOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .highlightedFret, vertical: .highlightedString)) {
            FretboardView(fretboard: challenge.configuration.fretboard, highlightedFret: challenge.question.fret, highlightedString: challenge.question.string)
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


struct FretboardIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FretboardIndicatorView()
            .environmentObject(Challenge())
            .frame(height: 400)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            FretboardIndicatorView()
            .environmentObject(Challenge())
            .frame(height: 400)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
