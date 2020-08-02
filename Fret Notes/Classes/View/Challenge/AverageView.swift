//
//  AverageView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 2/8/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct AverageView: View {

    @EnvironmentObject var average: Average

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            HStack(alignment: .center, spacing: 4) {
                Text("Average")
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("\(average.value ?? 0, specifier: "%.2f")").font(.title)
                    Text("seconds").font(.caption)
                }
            }

            Button(action: average.reset) {
                Text("Reset").font(.subheadline)
                Image(systemName: "arrow.counterclockwise")
            }
            .disabled(average.value == nil)
            .padding(.all, 8)
            .background(background())
            .foregroundColor(foregroundColor())
            .cornerRadius(4)
        }
        .accessibilityElement(children: .combine)
        .accessibility(label: accessibilityLabel())
        .accessibility(value: accessibilityValue())
        .accessibilityAction(named: Text("Reset"), average.reset)
    }


    // MARK: Private helper methods

    private func background() -> some View {
        return average.value == nil ? Color("Action.accent.disabled") : Color("Action.accent")
    }


    private func foregroundColor() -> Color {
        return average.value == nil ? Color("Action.foreground.disabled") : Color("Action.foreground")
    }


    private func accessibilityLabel() -> Text {
        return Text("Your answer's average time")
    }


    private func accessibilityValue() -> Text {
        return Text("\(average.value ?? 0, specifier: "%.2f") seconds")
    }
}


struct AverageView_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            AverageView()
            .environmentObject(Average(timings: [2, 4]))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.light)

            AverageView()
            .environmentObject(Average(timings: []))
            .previewLayout(PreviewLayout.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
