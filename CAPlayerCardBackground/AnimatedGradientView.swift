//
//  AnimatedGradientView.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import Combine
import SwiftUI
import UIKit

public class AnimatedGradientView: UIView {
    var duration: Double

    var cancellables = Set<AnyCancellable>()

    init(blobs: [[UIColor]], duration: Double) {
        self.duration = duration
        super.init(frame: .zero)

        create(blobs)
        DispatchQueue.main.async {
            self.update(duration: duration)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func create(_ blobs: [[UIColor]]) {
        layer.sublayers?.forEach { ($0 as? BlobLayer)?.removeFromSuperlayer() }
        for colors in blobs {
            layer.addSublayer(
                BlobLayer(blob: .random(withColors: colors), viewSize: frame.size)
            )
        }
    }

    public func update(duration: CGFloat) {
        cancellables.removeAll()
        self.duration = duration
        guard duration > 0 else { return }

        (layer.sublayers ?? [])
            .compactMap { $0 as? BlobLayer }
            .forEach { layer in
                Timer.publish(every: duration, on: .main, in: .common)
                    .autoconnect()
                    .sink { _ in
                        layer.morphBlob(
                            to: .random(withColors: layer.blob.colors), duration: duration
                        )
                    }
                    .store(in: &cancellables)
            }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        (layer.sublayers ?? [])
            .compactMap { $0 as? BlobLayer }
            .forEach { $0.viewSize = bounds.size }
    }
}

struct AnimatedGradientView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            AnimatedGradient(
                blobs: [[.white, .blue, .red]],
                duration: 1
            )
        }
    }
}
