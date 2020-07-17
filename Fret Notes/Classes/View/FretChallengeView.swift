//
//  FretChallengeView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct FretChallengeView: View {

    @StateObject private var game = Challenge()

    @State private var result: Result?

    private let columns: [GridItem] = [
        GridItem(.flexible(minimum: 48, maximum: .infinity)),
        GridItem(.flexible(minimum: 48, maximum: .infinity))
    ]

    var body: some View {
        VStack(alignment: .center, spacing: 40) {
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("Question:")
                }
                .font(.headline)
                .padding(.top, 40)

                HStack(alignment: .center, spacing: 40) {
                    Text("Fret \(game.question.fret)")
                    Text("String \(game.question.string)")
                }
                .font(.title)
            }

            LazyVGrid(columns: columns, alignment: .center, spacing: 12) {
                ForEach(Note.allCases, id: \.self) { note in
                    NoteButton(action: {
                        self.result = self.game.result(for: note)
                    }, note: note)
                }
            }
        }
        .sheet(item: $result) { result in
            ResultView(action: {
                self.game.nextQuestion()
                self.result = nil
            }, result: result)
        }
    }
}


struct ResultView: View {

    let action: () -> Void
    let result: Result

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack {
                Text("Answer:")
            }
            .font(.headline)
            .padding(.top, 40)

            VStack(alignment: .center, spacing: 40) {
                if result.isCorrect {
                    HStack(alignment: .center, spacing: 40) {
                        Image(systemName: "hand.thumbsup")
                        Text("Correct!")
                    }
                    Text("Time: \(result.timing) sec")
                } else {
                    HStack(alignment: .center, spacing: 40) {
                        Image(systemName: "hand.thumbsdown")
                        Text("Wrong!")
                    }
                    Text("Was: \(result.question.note.rawValue)")
                }

                Button(action: action) {
                    Text("Continue")
                }
            }
            .font(.title)
        }
    }
}


struct NoteButton: View {

    let action: () -> Void
    let note: Note

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(note.rawValue)
                    .font(.largeTitle)
            }
            .padding(24)
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .mask(Circle())
        }
    }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FretChallengeView()
    }
}
