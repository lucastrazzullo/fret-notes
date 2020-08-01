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
                Text(challenge.configuration.title).underline()
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
