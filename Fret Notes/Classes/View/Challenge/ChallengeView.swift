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

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center, spacing: 8) {
                    FretboardIndicatorView()
                    RecapView()
                }
                .frame(width: geometry.size.width)
                .padding(.top, 12).padding(.bottom, 8)
                .background(self.topBackgroundColor())

                DashboardView()
                .padding(.all, 12)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)

                NoteSelectionView()
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .animation(self.reduceMotion ? .none : .default)
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

struct ContentView_Previews: PreviewProvider {

    private static let configuration: Configuration = Configuration(with: .startBoard)

    private static let noAnsweredChallenge: Challenge = Challenge(configuration: .init())
    private static let correctlyAnsweredChallenge: Challenge = {
        let challenge = Challenge(configuration: configuration)
        let question = challenge.question
        let fretboard = configuration.fretboard
        let note = fretboard.note(on: question.fret, string: question.string)
        challenge.attemptAnswer(with: note)
        return challenge
    }()
    private static let wronglyAnsweredChallenge: Challenge = {
        let challenge = Challenge(configuration: configuration)
        let question = challenge.question
        let fretboard = configuration.fretboard
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