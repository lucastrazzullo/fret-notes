//
//  ResultView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct OptionalResultView: View {

    let result: Result?
    let action: () -> ()

    var body: some View {
        ZStack {
            buildView()
        }
    }

    private func buildView() -> AnyView {
        if let result = result {
            return AnyView(ResultView(result: result, action: action))
        } else {
            return AnyView(EmptyView())
        }
    }
}


struct ResultView: View {

    let result: Result
    let action: () -> ()

    var body: some View {
        VStack(alignment: .center, spacing: 24) {
            if result.isCorrect {
                VStack {
                    Text("🥁").font(.largeTitle)
                    Text("Good Job!").font(.headline)
                }
                .frame(maxWidth: .infinity)
            } else {
                VStack {
                    Text("🔕").font(.largeTitle)
                    Text("Wrong note!").font(.headline)
                }
                .frame(maxWidth: .infinity)
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

            Button(action: self.action) {
                Text("Next").fixedSize()
            }
            .padding(8)
            .background(Color("Action.accent"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
            .accessibility(removeTraits: .isButton)
        }
        .accessibilityElement(children: .combine)
        .accessibilityAction(named: Text("Next"), self.action)
        .accessibility(label: accessibilityLabel())
    }


    // MARK: Private helper methods

    private func accessibilityLabel() -> Text {
        var commonString = "The correct note is \(result.question.note.name) \(result.question.note.symbolExtended ?? "")."
        commonString += "Answered in \(Int(result.timing)) seconds"
        if result.isCorrect {
            return Text("Good job! Your answer is correct. \(commonString)")
        } else {
            return Text("Wrong Answer! \(commonString)")
        }
    }
}


struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultView(result: Result(question: Question(fret: 5, string: 6, on: Fretboard(.standard)), attemptedAnswer: Answer(note: .a)), action: {})
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            ResultView(result: Result(question: Question(fret: 1, string: 1, on: Fretboard(.standard)), attemptedAnswer: Answer(note: .a)), action: {})
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
