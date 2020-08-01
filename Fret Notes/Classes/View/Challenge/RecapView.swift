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
                Text(title(for: challenge.configuration)).underline()
                Image(systemName: "list.dash")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
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
        let buttonLabel = { (configuration: Configuration) -> Text in
            if self.challenge.configuration.fretboard == configuration.fretboard {
                return Text(self.title(for: configuration) + " ✔︎")
            } else {
                return Text(self.title(for: configuration))
            }
        }
        var buttons = Configuration.Default.allCases
            .map(Configuration.init(with:))
            .map { configuration -> ActionSheet.Button in
                .default(buttonLabel(configuration)) {
                    self.challenge.updateConfiguration(configuration)
                }
            }
        buttons.append(ActionSheet.Button.cancel())
        return buttons
    }


    private func title(for configuration: Configuration) -> String {
        return "\(configuration.fretboard.frets.lowerBound)th to \(configuration.fretboard.frets.upperBound)th fret"
    }
}


struct ChallengeRecapView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RecapView()
            .environmentObject(Challenge())
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            RecapView()
            .environmentObject(Challenge())
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
