//
//  ContentView.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [[Color]] = [
        [.green, .yellow],
        [.orange, .pink],
        [.purple, .indigo]
    ]

    var body: some View {
        ZStack {
            Color(uiColor: .systemFill)
                .ignoresSafeArea()
            gradient
                .background(Color(uiColor: .secondarySystemFill))
                .cornerRadius(10)
                .padding()
        }
    }

    var gradient: some View {
        AnimatedGradient(
            colors: colors,
            duration: 1
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
