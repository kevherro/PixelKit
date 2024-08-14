//===----------------------------------------------------------------------===//
//
// This source file is part of the PixelKit open source project
//
// Copyright (c) 2024 Kevin Herro
// Licensed under MIT
//
// See LICENSE.txt for license information
//
// SPDX-License-Identifier: MIT
//
//===----------------------------------------------------------------------===//

import SwiftUI

extension PixelKit.Animations {
  /// A view that displays a pulsing circle animation.
  ///
  /// `Pulse` creates a circle that expands and fades out,
  /// creating a pulsing effect.
  /// This can be used to draw attention to a specific area of your UI,
  /// or to create a visual rhythm.
  ///
  /// Example usage:
  /// ```swift
  /// Pulse(
  ///   color: .blue,
  ///   duration: 1.0,
  ///   finalScale: 2.5,
  ///   repeatsForever: true,
  ///   maxWidth: 50.0
  /// )
  /// ```
  public struct Pulse: View {
    /// The color of the pulsing circle.
    private let color: Color

    /// The duration of one pulse animation cycle.
    private let duration: Double

    /// The scale factor the circle reaches at the end of the animation.
    private let finalScale: CGFloat

    /// The max width of the circle before animation begins.
    private let maxWidth: CGFloat

    /// Determines whether the pulse animation repeats indefinitely.
    private let repeatForever: Bool

    /// Tracks whether the animation is currently active.
    @State private var isAnimating = false

    /// Initializes a new `Pulse`.
    ///
    /// - Parameters:
    ///   - color: The color of the pulsing circle.
    ///   - duration: The duration of one pulse cycle in seconds.
    ///   - finalScale: The scale factor the circle reaches at the end of the animation.
    ///   - repeatForever: If true, the pulse repeats indefinitely. If false, it pulses only once.
    ///   - maxWidth: The max width of the circle before animation begins.
    public init(
      color: Color = .white,
      duration: Double = 0.7,
      finalScale: CGFloat = 2.0,
      repeatForever: Bool = false,
      maxWidth: CGFloat
    ) {
      self.color = color
      self.duration = duration
      self.finalScale = finalScale
      self.repeatForever = repeatForever
      self.maxWidth = maxWidth
    }

    public var body: some View {
      Circle()
        .stroke(lineWidth: 3)
        .frame(maxWidth: self.maxWidth)
        .foregroundColor(self.color)
        .opacity(self.isAnimating ? 0 : 1)
        .scaleEffect(self.isAnimating ? self.finalScale : 0)
        .onAppear {
          withAnimation(self.animation) {
            self.isAnimating = true
          }
        }
    }

    private var animation: Animation {
      let baseAnimation = Animation.easeOut(duration: self.duration)
      return self.repeatForever ? baseAnimation
        .repeatForever(autoreverses: false) : baseAnimation
    }
  }
}

// MARK: - Preview

struct Pulse_Previews: PreviewProvider {
  static var previews: some View {
    PixelKit.Animations.Pulse(color: .yellow, repeatForever: true, maxWidth: 50.0)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
