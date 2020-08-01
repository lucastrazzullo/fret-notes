//
//  DashboardView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct DashboardView: View {

    @EnvironmentObject var average: Average
    @EnvironmentObject var challenge: Challenge

    var body: some View {
        ZStack<AnyView> {
            if let result = self.challenge.result {
                return AnyView(ResultView(result: result, action: {
                    if let result = self.challenge.result, result.isCorrect {
                        self.average.add(timing: result.timing)
                    }
                    self.challenge.nextQuestion()
                }))
            } else {
                return AnyView(AverageView())
            }
        }
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
                    Text("Good Job!").font(.headline)
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
            .background(Color("Action.accent"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
        }
        .padding()
        .cornerRadius(12)
    }
}


struct AverageView: View {

    @EnvironmentObject var average: Average

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 4) {
                Text("Average")
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(average.value ?? 0, specifier: "%.2f")").font(.title)
                    Text("seconds").font(.caption)
                }
            }

            Button(action: average.reset) {
                Text("Reset").font(.subheadline)
                Image(systemName: "arrow.counterclockwise")
            }
            .disabled(average.value == nil)
            .padding(.all, 8)
            .background(average.value == nil ? Color("Action.accent.disabled") : Color("Action.accent"))
            .foregroundColor(average.value == nil ? Color("Action.foreground.disabled") : Color("Action.foreground"))
            .cornerRadius(4)
        }
    }
}


struct DashboardView_Previews: PreviewProvider {

    private static let noAnsweredChallenge: Challenge = Challenge()
    private static let correctlyAnsweredChallenge: Challenge = {
        let challenge = Challenge()
        let question = challenge.question
        let fretboard = challenge.fretboard
        let note = fretboard.note(on: question.fret, string: question.string)
        challenge.attemptAnswer(with: note)
        return challenge
    }()
    private static let wronglyAnsweredChallenge: Challenge = {
        let challenge = Challenge()
        let question = challenge.question
        let fretboard = challenge.fretboard
        let correctNote = fretboard.note(on: question.fret, string: question.string)
        var notes = Note.allCases
        notes.remove(at: Note.allCases.firstIndex(of: correctNote)!)
        let wrongNote = notes.first!
        challenge.attemptAnswer(with: wrongNote)
        return challenge
    }()

    static var previews: some View {
        Group {
            DashboardView()
            .environmentObject(noAnsweredChallenge)
            .environmentObject(Average(timings: [2, 4]))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            DashboardView()
            .environmentObject(noAnsweredChallenge)
            .environmentObject(Average(timings: []))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)

            DashboardView()
            .environmentObject(correctlyAnsweredChallenge)
            .environmentObject(Average(timings: []))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            DashboardView()
            .environmentObject(wronglyAnsweredChallenge)
            .environmentObject(Average(timings: []))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
