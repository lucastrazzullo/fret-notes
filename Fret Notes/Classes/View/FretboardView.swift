//
//  FretboardView.swift
//  Fret Notes
//
//  Created by luca strazzullo on 17/7/20.
//  Copyright © 2020 Luca Strazzullo. All rights reserved.
//

import SwiftUI

struct FretboardView: View {

    let middleFret: Int

    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: 12) {
                ForEach(frets(), id: \.self) { position in
                    FretView(position: position)
                }
            }
            .frame(maxWidth: .infinity)

            VStack(alignment: .center, spacing: 24) {
                VStack(alignment: .center, spacing: 40) {
                    Rectangle().frame(height: 1, alignment: .center)
                    Rectangle().frame(height: 1.2, alignment: .center)
                    Rectangle().frame(height: 1.8, alignment: .center)
                    Rectangle().frame(height: 2.4, alignment: .center)
                    Rectangle().frame(height: 3.2, alignment: .center)
                    Rectangle().frame(height: 4, alignment: .center)
                }
            }
            .frame(maxHeight: .infinity)

            VStack {
                Text("Fret \(middleFret)")
                Text("String 2")
            }
            .padding(.all, 8)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(4)
            .offset(x: 0, y: -66)
        }
    }


    // MARK: Private helper methods

    private func frets() -> [Int] {
        return Array(middleFret-2...middleFret+2)
    }
}


struct FretView: View {

    private static let markPositions: Set<Int> = [3, 5, 7, 9, 12, 15, 17, 19]

    let position: Int

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.gray)
                .opacity(exists() ? 0.2 : 0)

            if hasMarker() {
                Circle().frame(width: 12, height: 12, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }


    // MARK: Private helper methods

    private func hasMarker() -> Bool {
        return FretView.markPositions.contains(position)
    }


    private func exists() -> Bool {
        return position > 0
    }
}


struct FretboardView_Previews: PreviewProvider {
    static var previews: some View {
        FretboardView(middleFret: 2)
    }
}
