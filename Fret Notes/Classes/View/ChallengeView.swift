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
            GeometryReader { geometry in
                FretboardIndicatorView(challenge: challenge, fretboardOffset: fretboardOffset(for: challenge.question.fret, in: geometry))
                .edgesIgnoringSafeArea(.all)
            }

            ZStack {
                if let result = result {
                    ResultView(result: result, action: nextQuestion)
                } else if let value = average.value {
                    AverageView(average: value, reset: average.reset)
                }
            }
            .padding(.all, 12)
            .background(Color.white.opacity(0.2))
            .cornerRadius(12)

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
        .animation(.default)
        .background(Color("Challenge.background").edgesIgnoringSafeArea(.all))
    }


    // MARK: Private helper methods

    private func nextQuestion() {
        if let result = result, result.isCorrect {
            average.add(timing: result.timing)
        }
        result = nil
        challenge.nextQuestion()
    }


    private func fretboardOffset(for fret: Int, in viewportGeometry: GeometryProxy) -> CGFloat {
        let leftFrets = Array(0...fret + 1)
        let leftWidth = leftFrets.reduce(0, { $0 + FretboardView.fretWidth(at: $1) })
        return -CGFloat(leftWidth - viewportGeometry.size.width / 2)
    }
}


struct FretboardIndicatorView: View {

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


    // MARK: Instance properties

    @ObservedObject var challenge: Challenge

    let fretboardOffset: CGFloat

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .highlightedFret, vertical: .highlightedString)) {
            FretboardView(fretboard: challenge.fretboard, highlightedFret: challenge.question.fret, highlightedString: challenge.question.string)
            IndicatorView()
        }
        .offset(x: fretboardOffset, y: 0)
        .background(backgroundColor())
    }


    // MARK: Private helper methods

    private func backgroundColor() -> some View {
        Color("FretboardIndicator.background")
        .edgesIgnoringSafeArea(.all)
        .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 2)
    }
}


struct ResultView: View {

    let result: Result
    let action: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            VStack {
                if result.isCorrect {
                    Text("🥁").font(.largeTitle)
                    Text("Well Job!").font(.headline)
                } else {
                    Text("🔕").font(.largeTitle)
                    Text("Wrong note!").font(.headline)
                }
            }
            VStack {
                HStack {
                    Text(result.question.note.fullName).bold()
                    Text("is the correct note")
                }
                HStack {
                    Text("Answered in")
                    Text("\(result.timing, specifier: "%.2f")").font(.headline)
                    Text("seconds").font(.callout)
                }
            }
            Button(action: action) {
                Text("Next")
            }
            .padding(.all, 8)
            .background(Color("Action.background"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
        }
        .padding()
        .cornerRadius(12)
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
                .frame(width: 100, height: 36, alignment: .center)
            Rectangle()
                .opacity(0.2)
                .frame(width: 1)
            Text("String \(question.string)")
                .frame(width: 100, height: 36, alignment: .center)
        }
        .font(.headline)
    }
}


struct ButtonsView: View {

    let action: (Note) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 4) {
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
            .preferredColorScheme(.dark)
    }
}
