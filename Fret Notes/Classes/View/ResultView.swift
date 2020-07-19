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
                    HStack(alignment: .center, spacing: 12) {
                        Image(systemName: "hand.thumbsup")
                        Text("Correct!")
                    }
                    Text("Time: \(result.timing) sec")
                } else {
                    HStack(alignment: .center, spacing: 12) {
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


struct ResultView_Previews: PreviewProvider {

    static var previews: some View {
        let fretboard = FretBoard(tuningType: .standard)
        let question = Question(fret: 2, string: 2, on: fretboard)
        let answer = Answer(note: question.note)
        let result = Result(question: question, attemptedAnswer: answer)
        return ResultView(action: {}, result: result)
    }
}
