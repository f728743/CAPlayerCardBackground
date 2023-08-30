//
//  BlobLayer.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import QuartzCore

public class BlobLayer: CAGradientLayer {
    private(set) var blob: Blob
    var viewSize: CGSize {
        didSet {
            frame = CGRect(
                origin: blob.positionInRect(withSize: viewSize),
                size: blob.shape.size
            )
        }
    }

    init(blob: Blob, viewSize: CGSize) {
        self.blob = blob
        self.viewSize = viewSize
        super.init()
        colors = blob.cgColors
        cornerRadius = blob.cornerRadius
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public init(layer: Any) {
        blob = .init()
        viewSize = .zero
        super.init(layer: layer)
    }

    func morphBlob(to blob: Blob, duration: Double) {
        let position = makeAnimation(
            .position,
            from: self.blob.animationPositionInRect(withSize: viewSize),
            to: blob.animationPositionInRect(withSize: viewSize)
        )
        let size = makeAnimation(.bounds, from: self.blob.bounds, to: blob.bounds)
        let cornerRadius = makeAnimation(.cornerRadius, from: self.blob.cornerRadius, to: blob.cornerRadius)
        let scale = makeAnimation(.scale, from: self.blob.shape.scale, to: blob.shape.scale)
        let rotation = makeAnimation(.rotate, from: self.blob.shape.rotation, to: blob.shape.rotation)
        let colors = makeAnimation(.colors, from: self.blob.cgColors, to: blob.cgColors)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [position, size, cornerRadius, scale, rotation, colors]
        groupAnimation.fillMode = .forwards
        groupAnimation.duration = duration
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        removeAllAnimations()
        add(groupAnimation, forKey: "animations")

        self.blob = blob
    }
}

private extension BlobLayer {
    func makeAnimation(_ animationType: Animation, from _: Any, to: Any) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: animationType.rawValue)
        animation.fromValue = presentation()?.value(forKeyPath: animationType.rawValue)
//        animation.fromValue = from
        animation.toValue = to
        return animation
    }
}

private enum Animation: String {
    case position
    case bounds
    case scale = "transform.scale"
    case cornerRadius
    case rotate = "transform.rotation"
    case colors
}

private extension Blob {
    var cornerRadius: CGFloat { min(shape.size.width, shape.size.height) / 2 }
    var bounds: CGRect { .init(origin: .zero, size: shape.size) }
    var cgColors: [CGColor] { colors.map { $0.cgColor } }

    func animationPositionInRect(withSize size: CGSize) -> CGPoint {
        positionInRect(withSize: size, considerBlobSize: false)
    }

    func positionInRect(withSize size: CGSize, considerBlobSize: Bool = true) -> CGPoint {
        let adjustSize: CGSize = considerBlobSize ? self.shape.size : .zero
        let res: CGPoint = .init(
            x: shape.position.x + (size.width - adjustSize.width) / 2,
            y: shape.position.y + (size.height - adjustSize.height) / 2
        )
        return res
    }
}
