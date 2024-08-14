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
    let color: Color

    /// The duration of one pulse animation cycle.
    let duration: Double

    /// The scale factor the circle reaches at the end of the animation.
    let finalScale: CGFloat

    /// The max width of the circle before animation begins.
    let maxWidth: CGFloat

    /// Determines whether the pulse animation repeats indefinitely.
    let repeatForever: Bool

    /// Tracks whether the animation is currently active.
    @State private var isAnimating = false

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
