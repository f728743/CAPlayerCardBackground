//
//  Blob.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import UIKit

struct BlobGeometry {
    let position: CGPoint
    let size: CGSize
    let scale: CGFloat
    let rotation: CGFloat
}

struct Blob {
    let colors: [UIColor]
    let shape: BlobGeometry
    let moveDuration: Double
}

extension BlobGeometry {
    static var zero: BlobGeometry {
        .init(position: .zero, size: .zero, scale: .zero, rotation: .zero)
    }
}

extension Blob {
    init() {
        self.init(colors: [], shape: .zero, moveDuration: 0)
    }

    private static var index = 0

    static let hardcoded: [Blob] = [
        .init(
            colors: [],
            shape: .init(
                position: .init(x: -100, y: -100),
                size: .init(width: 120, height: 200),
                scale: 1,
                rotation: 0
            ),
            moveDuration: 1
        ),
        .init(
            colors: [],
            shape: .init(
                position: .init(x: 100, y: 100),
                size: .init(width: 200, height: 200),
                scale: 0.5,
                rotation: CGFloat.pi / 3
            ),
            moveDuration: 1
        ),

            .init(
                colors: [],
                shape: .init(
                    position: .init(x: 150, y: -100),
                    size: .init(width: 150, height: 100),
                    scale: 1.5,
                    rotation: CGFloat.pi / 2
                ),
                moveDuration: 1
            ),
        .init(
            colors: [],
            shape: .init(
                position: .init(x: 0, y: 0),
                size: .init(width: 100, height: 100),
                scale: 1.5,
                rotation: CGFloat.pi
            ),
            moveDuration: 1
        )
    ]

        static func random(withColors colors: [UIColor]) -> Blob {
            let res = hardcoded[index]
            index += 1
            if index == hardcoded.count {
                index = 0
            }
            return .init(
                colors: colors,
                shape: res.shape,
                moveDuration: res.moveDuration
            )
        }
}
