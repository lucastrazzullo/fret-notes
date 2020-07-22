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
    @ObservedObject var average: Average

    @State private var result: Result?

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            FretboardIndicatorView(challenge: challenge)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 12)

            if let value = average.value {
                AverageView(average: value, reset: average.reset)
                .padding(.all, 12)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)
            }

            VStack(alignment: .center, spacing: 12) {
                QuestionView(question: challenge.question)
                .padding(12)
                .frame(maxWidth: .infinity, maxHeight: 64)

                ButtonsView(action: { note in
                    result = challenge.result(for: note)
                })
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .alert(item: $result) { answerResult in
            if answerResult.isCorrect {
                return Alert(title: Text("Correct!"),
                             message: Text("Time: \(answerResult.timing, specifier: "%.2f") sec"),
                             dismissButton: .default(Text("Next"), action: {
                                challenge.nextQuestion()
                                average.add(timing: answerResult.timing)
                                result = nil
                }))
            } else {
                return Alert(title: Text("Wrong!"),
                             message: Text("It was: \(answerResult.question.note.name)\(answerResult.question.note.symbol ?? "")"),
                             dismissButton: .default(Text("Next"), action: {
                                challenge.nextQuestion()
                                result = nil
                }))
            }
        }
        .animation(.default)
        .background(Color("Challenge.background"))
        .edgesIgnoringSafeArea(.all)
    }
}


struct AverageView: View {

    let average: Double
    let reset: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("Average")
                Text("\(average, specifier: "%.2f")").font(.title)
                Text("seconds").font(.caption2)
            }

            Button(action: reset) {
                Text("Reset").font(.subheadline)
                Image(systemName: "arrow.counterclockwise")
            }
            .padding(.all, 8)
            .background(Color("Action.background"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
        }
    }
}


struct QuestionView: View {

    let question: Question

    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            Text("Fret \(question.fret)")
            Rectangle().frame(width: 1).opacity(0.2)
            Text("String \(question.string)")
        }
        .font(.headline)
    }
}


struct FretboardIndicatorView: View {

    @Environment(\.colorScheme) var colorScheme

    @ObservedObject var challenge: Challenge

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .highlightedString)) {
            FretboardView(fretboard: challenge.fretboard, middleFret: challenge.question.fret, highlightedString: challenge.question.string)

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
            .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
        }
        .background(Color("FretboardIndicator.background"))
        .mask(BottomRadiusShape(radius: 24))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: -2)
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
        ChallengeView(challenge: Challenge(), average: Average(timings: [2.3, 3.4]))
            .preferredColorScheme(.light)
    }
}
