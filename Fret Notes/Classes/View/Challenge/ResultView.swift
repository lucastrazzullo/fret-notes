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
        buildView()
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
                .accessibilityElement(children: .combine)
                .accessibility(label: Text("Good job! Your answer is correct."))
            } else {
                VStack {
                    Text("🔕").font(.largeTitle)
                    Text("Wrong note!").font(.headline)
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .combine)
                .accessibility(label: Text("Wrong answer!"))
            }

            VStack {
                HStack {
                    Text(result.question.note.fullName).bold()
                    Text("is the correct note")
                }
                .accessibilityElement(children: .combine)
                .accessibility(label: Text("The correct note is \(result.question.note.name) \(result.question.note.symbolExtended ?? "")"))

                HStack {
                    Text("Answered in")
                    Text("\(result.timing, specifier: "%.2f")").font(.headline)
                    Text("seconds").font(.callout)
                }
                .accessibilityElement(children: .combine)
                .accessibility(label: Text("Answered in \(result.timing, specifier: "%.2f") seconds"))
            }

            Button(action: self.action) {
                Text("Next").fixedSize()
            }
            .padding(8)
            .background(Color("Action.accent"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
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
