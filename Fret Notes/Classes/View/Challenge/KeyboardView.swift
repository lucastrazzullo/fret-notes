//
//  KeyboardView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct KeyboardView: View {

    @EnvironmentObject var challenge: Challenge

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 28) {
                ForEach(0..<4, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 28) {
                ForEach(4..<8, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 28) {
                ForEach(8..<12, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
        }
    }


    private func buildButton(for note: Note) -> some View {
        Button(action: { self.challenge.attemptAnswer(with: note) }) {
            ZStack(alignment: .center) {
                Text(note.name.uppercased())
                Text(note.symbol ?? "")
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment(horizontal: .trailing, vertical: .top))
            }
        }
        .buttonStyle(KeyboardButtonStyle())
        .accessibilityElement(children: .combine)
        .accessibility(label: Text("\(note.name), \(note.symbol != nil ? "Sharp" : "")"))
        .accessibility(hint: Text("Click to answer: \(note.name) \(note.symbolExtended ?? "")"))
    }
}


struct KeyboardButtonStyle: ButtonStyle {

    let size: CGFloat = 36

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
        .font(.headline)
        .foregroundColor(.primary)
        .frame(width: size, height: size)
        .padding(12)
        .background(background(for: configuration))
    }


    // MARK: Private helper methods

    private func background(for configuration: Self.Configuration) -> some View {
        if configuration.isPressed {
            return AnyView(Circle()
            .foregroundColor(Color.black.opacity(0.15)))
        } else {
            return AnyView(Circle()
            .stroke(lineWidth: 3)
            .foregroundColor(Color.black.opacity(0.15)))
        }
    }
}


struct AnswerButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            KeyboardView()
            .environmentObject(Challenge(fretboard: .init(), average: .init(timings: [])))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            KeyboardView()
            .environmentObject(Challenge(fretboard: .init(), average: .init(timings: [])))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
