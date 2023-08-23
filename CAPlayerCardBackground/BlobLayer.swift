//
//  BlobLayer.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import SwiftUI

private extension Blob {
    var cornerRadius: CGFloat {
        min(size.width, size.height) / 2
    }

    func animatinPositionInRect(withSize size: CGSize) -> CGPoint {
        positionInRect(withSize: size, considerBlobSize: false)
    }

    func positionInRect(withSize size: CGSize, considerBlobSize: Bool = true) -> CGPoint {
        let adjustSize: CGSize = considerBlobSize ? self.size : .zero
        let res: CGPoint = .init(
            x: position.x + (size.width - adjustSize.width) / 2,
            y: position.y + (size.height - adjustSize.height) / 2
        )
        return res
    }
}

public class BlobLayer: CAGradientLayer {
    private(set) var blob: Blob
    var viewSize: CGSize {
        didSet {
            frame = CGRect(
                origin: blob.positionInRect(withSize: viewSize),
                size: blob.size
            )
        }
    }

    init(blob: Blob, colors: [CGColor], viewSize: CGSize) {
        self.blob = blob
        self.viewSize = viewSize
        super.init()
        self.colors = colors
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
        removeAllAnimations()

        let position = makePositionAnimation(from: self.blob, to: blob)
        let size = makeResizeAnimation(from: self.blob, to: blob)
        let cornerRadius = makeCornerRadiusAnimation(from: self.blob, to: blob)
        let scale = makeScaleAnimation(from: self.blob, to: blob)
        let rotate = makeRotateAnimation(from: self.blob, to: blob)

        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [position, size, cornerRadius, scale, rotate]
        groupAnimation.fillMode = .forwards
        groupAnimation.duration = duration
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        add(groupAnimation, forKey: "frame")

        self.blob = blob
    }

    func makePositionAnimation(from: Blob, to: Blob) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = from.animatinPositionInRect(withSize: viewSize)
        animation.toValue = to.animatinPositionInRect(withSize: viewSize)
        return animation
    }

    func makeResizeAnimation(from: Blob, to: Blob) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = CGRect(origin: .zero, size: from.size)
        animation.toValue = CGRect(origin: .zero, size: to.size)
        return animation
    }

    func makeScaleAnimation(from: Blob, to: Blob) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = from.scale
        animation.toValue = to.scale
        return animation
    }

    func makeCornerRadiusAnimation(from: Blob, to: Blob) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        animation.fromValue = from.cornerRadius
        animation.toValue = to.cornerRadius
        return animation
    }

    func makeRotateAnimation(from: Blob, to: Blob) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.fromValue = from.rotation
        animation.toValue = to.rotation
        return animation
    }
}
