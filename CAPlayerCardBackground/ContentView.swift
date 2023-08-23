//
//  ContentView.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [[Color]] = [
        [.blue, .green, .yellow],
        [.orange, .red, .pink],
        [.purple, .teal, .indigo]
    ]

    var body: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()
            gradient
                .background(Color(uiColor: .lightGray))
                .cornerRadius(8)
                .padding()
        }
    }

    var gradient: some View {
        AnimatedGradient(
            blobs: colors,
            duration: 1
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
