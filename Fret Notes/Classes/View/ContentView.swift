//
//  ContentView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var game = Game()

    @State private var isResultPresented: Bool = false

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
                    Button(action: {
                        self.game.attempt(answer: .init(note: note))
                        self.isResultPresented = true
                    }) {
                        NoteView(note: note)
                    }
                }
            }
        }
        .sheet(isPresented: $isResultPresented, onDismiss: game.nextQuestion) {
            VStack(alignment: .center, spacing: 20) {
                VStack {
                    Text("Answer:")
                }
                .font(.headline)
                .padding(.top, 40)

                VStack(alignment: .center, spacing: 40) {
                    if let answer = game.attemptedAnswer, answer.note == game.question.note {
                        let answerTime = answer.time.timeIntervalSinceNow
                        let questionTime = game.question.time.timeIntervalSinceNow
                        let seconds = abs(questionTime - answerTime)

                        HStack(alignment: .center, spacing: 40) {
                            Image(systemName: "hand.thumbsup")
                            Text("Correct!")
                        }
                        Text("Time: \(seconds) sec")
                    } else {
                        HStack(alignment: .center, spacing: 40) {
                            Image(systemName: "hand.thumbsdown")
                            Text("Wrong!")
                        }
                        Text("Was: \(game.question.note.rawValue)")
                    }
                }
                .font(.title)
            }
        }
    }
}


struct NoteView: View {

    let note: Note

    var body: some View {
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


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
