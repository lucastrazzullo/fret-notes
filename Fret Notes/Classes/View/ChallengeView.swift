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

                    VStack {
                        Text("Fret \(game.question.fret)")
                        Text("String \(game.question.string)")
                    }
                }
                .font(.headline)
                .padding(.top, 40)

                ZStack(alignment: Alignment(horizontal: .center, vertical: .highlightedString)) {
                    FretboardView(fretboard: game.fretboard, middleFret: game.question.fret, highlightedString: game.question.string)

                    IndicatorView()
                        .alignmentGuide(.highlightedString) { d in d[VerticalAlignment.center] }
                        .frame(width: 24, height: 24, alignment: .center)
                }
            }
            .background(Color.gray.opacity(0.4).edgesIgnoringSafeArea(.all))
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


    // MARK: Private helper methods

//    private func stringAlignment() -> VerticalAlignment {
//        switch game.question.string {
//        case 1:
//            return .firstString
//        case 2:
//            return .secondString
//        case 3:
//            return .thirdString
//        case 4:
//            return .fourthString
//        case 5:
//            return .fifthString
//        case 6:
//            return .sixthString
//        default:
//            return .center
//        }
//    }
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


struct IndicatorView: View {

    var body: some View {
        Circle()
            .foregroundColor(.accentColor)
            .opacity(0.8)
    }
}


// MARK: - Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
