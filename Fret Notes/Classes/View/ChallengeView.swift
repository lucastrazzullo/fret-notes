//
//  ChallengeView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 15/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct ChallengeView: View {

    @ObservedObject var challenge: Challenge
    @ObservedObject var average: Average

    @State private var result: Result?

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) {
                VStack(alignment: .center, spacing: 8) {
                    FretboardIndicatorView(fretboard: self.challenge.fretboard, question: self.challenge.question)
                    FretboardConfiguration(challenge: self.challenge)
                }
                .frame(width: geometry.size.width)
                .padding(.top, 12).padding(.bottom, 8)
                .background(Color("FretboardIndicator.background").edgesIgnoringSafeArea(.top).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2))


                ZStack<AnyView> {
                    if let result = self.result {
                        return AnyView(ResultView(result: result, action: self.nextQuestion))
                    } else if let value = self.average.value {
                        return AnyView(AverageView(average: value, reset: self.average.reset))
                    } else {
                        return AnyView(EmptyView())
                    }
                }
                .padding(.all, 12)
                .background(Color.white.opacity(0.2))
                .cornerRadius(12)

                ButtonsView(action: { note in
                    self.result = self.challenge.result(for: note)
                })
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
            .animation(.default)
            .frame(width: geometry.size.width)
            .background(Color("Challenge.background").edgesIgnoringSafeArea(.all))
        }
    }


    // MARK: Private helper methods

    private func nextQuestion() {
        if let result = result, result.isCorrect {
            average.add(timing: result.timing)
        }
        result = nil
        challenge.nextQuestion()
    }
}


struct FretboardConfiguration: View {

    @ObservedObject var challenge: Challenge

    @State private var showConfigurations: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center, spacing: 4) {
                Text("Fret \(challenge.question.fret)").font(.headline)
                Text("|")
                Text("String \(challenge.question.string)").font(.headline)
            }
            .padding()

            HStack {
                Text(challenge.configuration.title).underline()
                Image(systemName: "list.dash")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color("FretboardIndicator.background"))
            .foregroundColor(Color("Action.accent"))
            .onTapGesture {
                self.showConfigurations = true
            }
            .actionSheet(isPresented: $showConfigurations) {
                ActionSheet(title: Text("Fretboard configuration"), message: nil, buttons: fretboardConfigurationButtons())
            }
        }
    }


    // MARK: Private helper methods

    private func fretboardConfigurationButtons() -> [ActionSheet.Button] {
        let buttonLabel = { (item: FretboardConfigurations.ConfigurationItem) -> Text in
            if self.challenge.configuration.frets == item.frets {
                return Text(item.title + " ✔︎")
            } else {
                return Text(item.title)
            }
        }
        var buttons = challenge.configurations.items.map { item -> ActionSheet.Button in
            .default(buttonLabel(item), action: { self.challenge.updateConfiguration(item) })
        }
        buttons.append(ActionSheet.Button.cancel())
        return buttons
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

    let average: Double
    let reset: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("Average")
                Text("\(average, specifier: "%.2f")").font(.title)
                Text("seconds").font(.caption)
            }

            Button(action: reset) {
                Text("Reset").font(.subheadline)
                Image(systemName: "arrow.counterclockwise")
            }
            .padding(.all, 8)
            .background(Color("Action.accent"))
            .foregroundColor(Color("Action.foreground"))
            .cornerRadius(4)
        }
    }
}


struct ButtonsView: View {

    let action: (Note) -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 2) {
            HStack(alignment: .center, spacing: 12) {
                ForEach(0..<3, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(3..<6, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(6..<9, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
            HStack(alignment: .center, spacing: 12) {
                ForEach(9..<12, id: \.self) { row in
                    self.buildButton(for: Note.allCases[row])
                }
            }
        }
    }


    private func buildButton(for note: Note) -> some View {
        Button(action: { self.action(note) }) {
            HStack(alignment: .top, spacing: 4) {
                Text(note.name).font(.title).foregroundColor(.primary)
                Text(note.symbol ?? "").font(.headline).foregroundColor(.secondary)
            }
            .frame(maxWidth: 80, maxHeight: 32, alignment: .center)
        }
        .padding(12)
    }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView(challenge: Challenge(), average: Average(timings: [2.3, 3.4]))
            .preferredColorScheme(.light)
    }
}
