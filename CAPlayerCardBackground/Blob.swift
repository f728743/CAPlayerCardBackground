//
//  Blob.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import UIKit

struct Blob {
    let position: CGPoint
    let size: CGSize
    let scale: CGFloat
    let rotation: CGFloat
    let colors: [UIColor]
}

extension Blob {
    init() {
        self.init(
            position: .zero,
            size: .zero,
            scale: .zero,
            rotation: .zero,
            colors: []
        )
    }

    private static var index = 0

    static let hardcoded: [Blob] = [
        Blob(
            position: .init(x: -100, y: -100),
            size: .init(width: 120, height: 200),
            scale: 1,
            rotation: 0,
            colors: []
        ),
        Blob(
            position: .init(x: 100, y: 100),
            size: .init(width: 200, height: 200),
            scale: 0.5,
            rotation: CGFloat.pi / 3,
            colors: []
        ),
        Blob(
            position: .init(x: 150, y: -100),
            size: .init(width: 150, height: 100),
            scale: 1.5,
            rotation: CGFloat.pi / 2,
            colors: []

        ),
        Blob(
            position: .init(x: 0, y: 0),
            size: .init(width: 100, height: 100),
            scale: 1.5,
            rotation: CGFloat.pi,
            colors: []
        )
    ]

    static func random(withColors colors: [UIColor]) -> Blob {
        let res = hardcoded[index]
        index += 1
        if index == hardcoded.count {
            index = 0
        }
        return .init(position: res.position, size: res.size, scale: res.scale, rotation: res.rotation, colors: colors)
    }
}
