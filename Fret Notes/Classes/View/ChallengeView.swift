//
//  ChallengeView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {

    @StateObject private var game = Challenge()

    @State private var result: Result?

    var body: some View {
        AdaptiveStack(spacing: 40) {
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("What note is at")
                }
                .font(.headline)
                .padding(.top, 40)

                FretboardView(middleFret: game.question.fret)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            ButtonsView(action: { note in
                self.result = self.game.result(for: note)
            })
            .padding(.all, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .sheet(item: $result) { result in
            ResultView(action: {
                self.game.nextQuestion()
                self.result = nil
            }, result: result)
        }
    }
}


struct ButtonsView: View {

    private let layout: [GridItem] = [
        GridItem(.adaptive(minimum: 80))
    ]

    let action: (Note) -> Void

    var body: some View {
        LazyVGrid(columns: layout, spacing: 20) {
            ForEach(Note.allCases, id: \.self) { note in
                Button(action: { self.action(note) }) {
                    Text(note.rawValue)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
                .font(.title)
                .padding(12)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(12)
            }
        }
    }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
