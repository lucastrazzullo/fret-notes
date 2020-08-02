//
//  QuestionView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 2/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct QuestionView: View {

    @EnvironmentObject var challenge: Challenge

    var body: some View {
        HStack(alignment: .center, spacing: 4) {
            Text("Fret \(challenge.question.fret)").font(.headline)
            Text("|")
            Text("String \(challenge.question.string)").font(.headline)
        }
        .accessibilityElement(children: .combine)
        .accessibility(label: Text("Fret \(challenge.question.fret), String \(challenge.question.string)"))
        .accessibility(hint: Text("Guess the note"))
    }
}


struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            QuestionView()
            .environmentObject(Challenge(fretboard: .init(), average: .init(timings: [])))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            QuestionView()
            .environmentObject(Challenge(fretboard: .init(), average: .init(timings: [])))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
