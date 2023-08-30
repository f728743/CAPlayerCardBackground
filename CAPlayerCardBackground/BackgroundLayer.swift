//
//  BackgroundLayer.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 28.08.2023.
//

import QuartzCore

public class BackgroundLayer: CAGradientLayer {
    init(colors: [CGColor], viewSize _: CGSize) {
        super.init()
        self.colors = colors
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
