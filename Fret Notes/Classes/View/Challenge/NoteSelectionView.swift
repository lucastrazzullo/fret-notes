//
//  AnswerButtonsView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct AnswerButtonsView: View {

    @EnvironmentObject var challenge: Challenge

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            HStack(alignment: .center, spacing: 12) {
                ForEach(0..<3, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(3..<6, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(6..<9, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(9..<12, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
        }
    }


    private func buildButton(for note: Note) -> some View {
        Button(action: { self.challenge.attemptAnswer(with: note) }) {
            HStack(alignment: .top, spacing: 4) {
                Text(note.name).font(.title).foregroundColor(.primary)
                Text(note.symbol ?? "").font(.headline).foregroundColor(.primary)
            }
            .frame(maxWidth: 80, maxHeight: 32, alignment: .center)
            .accessibilityElement(children: .ignore)
        }
        .padding(12)
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Answer: \(note.name) \(note.symbol != nil ? "Sharp" : "")"))
        .accessibility(hint: Text("Click to answer: \(note.name) \(note.symbolExtended ?? "")"))
        .accessibility(addTraits: .isButton)
    }
}


struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnswerButtonsView()
            .environmentObject(Challenge(configuration: .init()))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            AnswerButtonsView()
            .environmentObject(Challenge(configuration: .init()))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
