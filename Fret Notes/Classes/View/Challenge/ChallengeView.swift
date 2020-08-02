//
//  ChallengeView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {

    @Environment(\.accessibilityReduceMotion) var reduceMotion

    @EnvironmentObject var challenge: Challenge

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(alignment: .center, spacing: 28) {
                    VStack {
                        OptionsView()
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .trailing)

                        FretboardIndicatorView()
                        .accessibility(hidden: true)
                    }
                    .frame(width: geometry.size.width)
                    .padding(.top, 12).padding(.bottom, 8)
                    .background(self.topBackgroundColor())
                    .accessibility(sortPriority: AccessibilityOrder.options.priority)
                    .accessibility(addTraits: .isHeader)

                    QuestionView()
                    .frame(width: geometry.size.width)
                    .accessibility(sortPriority: AccessibilityOrder.question.priority)
                    .accessibility(addTraits: .isHeader)

                    KeyboardView()
                    .frame(width: geometry.size.width)
                    .accessibility(sortPriority: AccessibilityOrder.answer.priority)

                    AverageView()
                    .padding(.all, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .accessibility(sortPriority: AccessibilityOrder.average.priority)
                    .accessibility(addTraits: .isHeader)
                }
                .accessibilityElement(children: .contain)
                .accessibility(hidden: self.challenge.result != nil)

                OptionalResultView(result: self.challenge.result, action: self.challenge.nextQuestion)
                .padding(24)
                .background(self.topBackgroundColor())
                .cornerRadius(12)
                .scaledToFit()
                .opacity(self.challenge.result == nil ? 0 : 1)
                .accessibilityElement(children: .combine)
                .accessibility(addTraits: self.challenge.result == nil ? [] : .isModal)
                .accessibility(hidden: self.challenge.result == nil)
                .accessibility(sortPriority: AccessibilityOrder.result.priority)
            }
            .accessibilityElement(children: .contain)
            .animation(self.reduceMotion ? .none : .default)
            .padding(.bottom, 24)
            .frame(width: geometry.size.width)
            .background(self.backgroundColor())
        }
    }


    // MARK: Private helper methods

    private func topBackgroundColor() -> some View {
        Color("Challenge.topBackground")
        .edgesIgnoringSafeArea(.top)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2)
    }


    private func backgroundColor() -> some View {
        Color("Challenge.background")
        .edgesIgnoringSafeArea(.all)
    }
}


// MARK: - Previews

struct ChallengeView_Previews: PreviewProvider {

    private static let configuration: Configuration = Configuration(with: .startBoard)

    private static let noAnsweredChallenge: Challenge = Challenge(fretboard: .init(), average: .init(timings: []))
    private static let correctlyAnsweredChallenge: Challenge = {
        let fretboard = configuration.fretboard
        let challenge = Challenge(fretboard: fretboard, average: .init(timings: []))
        let question = challenge.question
        let note = fretboard.note(on: question.fret, string: question.string)
        challenge.attemptAnswer(with: note)
        return challenge
    }()
    private static let wronglyAnsweredChallenge: Challenge = {
        let fretboard = configuration.fretboard
        let challenge = Challenge(fretboard: fretboard, average: .init(timings: []))
        let question = challenge.question
        let correctNote = fretboard.note(on: question.fret, string: question.string)
        var notes = Note.allCases
        notes.remove(at: Note.allCases.firstIndex(of: correctNote)!)
        let wrongNote = notes.first!
        challenge.attemptAnswer(with: wrongNote)
        return challenge
    }()

    static var previews: some View {
        Group {
            ChallengeView()
            .environmentObject(Average(timings: [2, 4]))
            .environmentObject(noAnsweredChallenge)
            .environmentObject(configuration)
            .preferredColorScheme(.light)

            ChallengeView()
            .environmentObject(Average(timings: []))
            .environmentObject(noAnsweredChallenge)
            .environmentObject(configuration)
            .preferredColorScheme(.dark)

            ChallengeView()
            .environmentObject(Average(timings: []))
            .environmentObject(correctlyAnsweredChallenge)
            .environmentObject(configuration)
            .preferredColorScheme(.light)

            ChallengeView()
            .environmentObject(Average(timings: []))
            .environmentObject(wronglyAnsweredChallenge)
            .environmentObject(configuration)
            .preferredColorScheme(.dark)
        }
    }
}
