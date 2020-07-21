//
//  ChallengeView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {

    @ObservedObject var challenge: Challenge

    @State private var result: Result?

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            FretboardIndicatorView(challenge: challenge)
            .padding(.top, 12)
            .background(Color.gray.opacity(0.4))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)

            VStack(alignment: .center, spacing: 12) {
                QuestionView(question: challenge.question)
                .padding(12)
                .frame(maxWidth: .infinity)

                ButtonsView(action: { note in
                    self.result = self.challenge.result(for: note)
                })
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .sheet(item: $result) { result in
            ResultView(action: {
                self.challenge.nextQuestion()
                self.result = nil
            }, result: result)
        }
    }
}


struct QuestionView: View {

    let question: Question

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Text("Fret \(question.fret)")
            Text("String \(question.string)")
        }
        .font(.headline)
    }
}


struct FretboardIndicatorView: View {

    @ObservedObject var challenge: Challenge

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .highlightedString)) {
            FretboardView(fretboard: challenge.fretboard, middleFret: challenge.question.fret, highlightedString: challenge.question.string)

            Circle()
                .foregroundColor(.accentColor)
                .opacity(0.8)
                .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
                .frame(width: 24, height: 24, alignment: .center)
        }
    }
}


struct ButtonsView: View {

    let action: (Note) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 12) {
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
        Button(action: { self.action(note) }) {
            HStack(alignment: .top, spacing: 4) {
                Text(note.name).font(.title).foregroundColor(.secondary)
                Text(note.symbol ?? "").font(.headline).foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, maxHeight: 32, alignment: .center)
        }
        .padding(12)
    }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge())
            .preferredColorScheme(.dark)
    }
}
