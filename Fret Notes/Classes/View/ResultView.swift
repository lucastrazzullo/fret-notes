//
//  ResultView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

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
                    VStack(alignment: .center, spacing: 12) {
                        HStack(alignment: .center, spacing: 12) {
                            Image(systemName: "hand.thumbsup")
                            Text("Correct!")
                        }
                        .font(.title)

                        Text("Time: \(result.timing) sec")
                    }
                } else {
                    VStack(alignment: .center, spacing: 12) {
                        HStack(alignment: .center, spacing: 12) {
                            Image(systemName: "hand.thumbsdown")
                            Text("Wrong!")
                        }
                        .font(.title)

                        HStack {
                            Text("Was:")
                            Text(result.question.note.name)
                            Text(result.question.note.symbol ?? "")
                        }
                    }
                }

                Button(action: action) {
                    Text("Continue")
                }
            }
        }
    }
}


struct ResultView_Previews: PreviewProvider {

    static var previews: some View {
        let fretboard = FretBoard(tuningType: .standard)
        let question = Question(fret: 2, string: 2, on: fretboard)
        let answer = Answer(note: Note.b)
        let result = Result(question: question, attemptedAnswer: answer)
        return ResultView(action: {}, result: result)
    }
}
