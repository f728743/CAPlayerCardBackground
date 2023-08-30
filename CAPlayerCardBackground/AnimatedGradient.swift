//
//  AnimatedGradient.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import SwiftUI

struct AnimatedGradient: UIViewRepresentable {
    let colors: [[Color]]
    let duration: Double

    func makeUIView(context _: Context) -> AnimatedGradientView {
        AnimatedGradientView(colors: colors.uiColors, duration: duration)
    }

    func updateUIView(_ view: AnimatedGradientView, context _: Context) {
        view.set(colors: colors.uiColors)
    }
}

private extension Array where Element == [Color] {
    var uiColors: [[UIColor]] { map { $0.map { UIColor($0) } } }
}

struct AnimatedGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            AnimatedGradient(
                colors: [[.white, .blue, .red]],
                duration: 1
            )
        }
    }
}
