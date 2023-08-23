//
//  Blob.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import Foundation

struct Blob {
    let position: CGPoint
    let size: CGSize
    let scale: CGFloat
    let rotation: CGFloat
}

extension Blob {
    init() {
        self.init(
            position: .zero,
            size: .zero,
            scale: .zero,
            rotation: .zero
        )
    }

    private static var index = 0
    
    static let hardcoded: [Blob] = [
        Blob(
            position: .init(x: -100, y: -100),
            size: .init(width: 120, height: 200),
            scale: 1,
            rotation: 0
        ),
        Blob(
            position: .init(x: 100, y: 100),
            size: .init(width: 200, height: 200),
            scale: 0.5,
            rotation: CGFloat.pi / 3
        ),
        Blob(
            position: .init(x: 150, y: -100),
            size: .init(width: 150, height: 100),
            scale: 1.5,
            rotation: CGFloat.pi / 2
        ),
        Blob(
            position: .init(x: 0, y: 0),
            size: .init(width: 100, height: 100),
            scale: 1.5,
            rotation: CGFloat.pi 
        )
    ]
    
    static var random: Blob {
        let res = hardcoded[index]
        index += 1
        if index == hardcoded.count {
            index = 0
        }
        return res
    }
}
