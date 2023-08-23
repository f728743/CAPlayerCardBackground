//
//  AnimatedGradient.swift
//  CAPlayerCardBackground
//
//  Created by Alexey Vorobyov on 22.08.2023.
//

import SwiftUI

public struct AnimatedGradient: View {
    private var blobs: [[Color]]
    private var duration: Double

    public init(blobs: [[Color]], duration: CGFloat) {
        self.blobs = blobs
        self.duration = duration
    }

    public var body: some View {
        Representable(blobs: blobs, duration: duration)
            .clipped()
    }
}

// MARK: - Representable

extension AnimatedGradient {
    struct Representable: UIViewRepresentable {
        var blobs: [[Color]]
        var duration: Double

        func makeView(context: Context) -> AnimatedGradientView {
            context.coordinator.view
        }

        func updateView(_: AnimatedGradientView, context: Context) {
            context.coordinator.create(blobs: blobs.map { $0.map { UIColor($0) } })
            DispatchQueue.main.async {
                context.coordinator.update(duration: duration)
            }
        }

        func makeUIView(context: Context) -> AnimatedGradientView {
            makeView(context: context)
        }

        func updateUIView(_ view: AnimatedGradientView, context: Context) {
            updateView(view, context: context)
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(
                blobs: blobs.map { $0.map { UIColor($0) } },
                duration: duration
            )
        }
    }

    class Coordinator {
        var blobs: [[UIColor]]
        var duration: Double
        var view: AnimatedGradientView

        init(blobs: [[UIColor]], duration: Double) {
            self.blobs = blobs
            self.duration = duration
            view = AnimatedGradientView(blobs: blobs, duration: duration)
        }

        func create(blobs: [[UIColor]]) {
            guard blobs != self.blobs else { return }
            self.blobs = blobs

            view.create(blobs)
            view.update(duration: duration)
        }

        func update(duration: CGFloat) {
            guard duration != self.duration else { return }
            self.duration = duration
            view.update(duration: duration)
        }
    }
}
