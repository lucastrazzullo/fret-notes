//
//  RecapView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 1/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct RecapView: View {

    @EnvironmentObject var challenge: Challenge
    @EnvironmentObject var configuration: Configuration

    @State private var showFretSections: Bool = false

    var body: some View {
        HStack(alignment: .center) {
            HStack(alignment: .center, spacing: 4) {
                Text("Fret \(challenge.question.fret)").font(.headline)
                Text("|")
                Text("String \(challenge.question.string)").font(.headline)
            }
            .padding()

            HStack {
                Text(fretSectionItemTitle(for: configuration.fretboard.frets)).underline()
                Image(systemName: "list.dash")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            .foregroundColor(Color("Action.accent"))
            .onTapGesture {
                self.showFretSections = true
            }
            .actionSheet(isPresented: $showFretSections) {
                ActionSheet(title: Text("Fretboard configuration"), message: nil, buttons: fretSectionButtons())
            }
        }
    }


    // MARK: Private helper methods

    private func fretSectionButtons() -> [ActionSheet.Button] {
        let buttonLabel = { (frets: ClosedRange<Int>) -> Text in
            if self.configuration.fretboard.frets == frets {
                return Text(self.fretSectionItemTitle(for: frets) + " ✔︎")
            } else {
                return Text(self.fretSectionItemTitle(for: frets))
            }
        }
        var buttons = Configuration.FretSection.allCases
            .map { fretSection -> ActionSheet.Button in
                .default(buttonLabel(fretSection.frets)) {
                    self.configuration.update(with: fretSection)
                }
            }
        buttons.append(ActionSheet.Button.cancel())
        return buttons
    }


    private func fretSectionItemTitle(for fretSection: ClosedRange<Int>) -> String {
        return "\(fretSection.lowerBound)th to \(fretSection.upperBound)th fret"
    }
}


struct ChallengeRecapView_Previews: PreviewProvider {

    private static let configuration: Configuration = Configuration(with: .endBoard)

    static var previews: some View {
        Group {
            RecapView()
            .environmentObject(Challenge(configuration: .init()))
            .environmentObject(configuration)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            RecapView()
            .environmentObject(Challenge(configuration: .init()))
            .environmentObject(configuration)
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
