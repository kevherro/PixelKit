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

import Combine
import SwiftUI

extension PixelKit.Animations {
  /// A view that displays a blinking ellipsis animation.
  ///
  /// `BlinkingEllipsis` creates an animated ellipsis effect using three circles that
  /// blink in sequence.
  /// This can be useful for indicating loading states,
  /// ongoing processes, or any scenario where a subtle,
  /// repeating animation is desired.
  ///
  /// Key features:
  /// - Customizable color
  /// - Adjustable animation timing
  /// - Smooth, looping animation
  /// - Lightweight and easy to integrate
  ///
  /// Usage:
  /// ```swift
  /// BlinkingEllipsis(color: .blue, interval: 0.5)
  /// ```
  ///
  /// - Note: This view uses SwiftUI's animation system and a timer publisher
  ///         to create a smooth, continuously looping animation.
  public struct BlinkingEllipsis: View {
    /// The current index of the circle that should be fully opaque.
    @State private var currentIndex = 0

    /// The color of the blinking circles.
    let color: Color

    /// The timer that drives the animation,
    /// determining how frequently the circles blink.
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    /// Initializes a new `BlinkingEllipsis` view.
    ///
    /// - Parameters:
    ///   - color: The color of the blinking circles. Defaults to `.primary`.
    ///   - interval: The time interval between each blink, in seconds. Defaults to 0.5
    /// seconds.
    public init(
      color: Color = .primary,
      interval: Double = 0.5
    ) {
      self.color = color
      self.timer = Timer.publish(
        every: interval,
        on: .main,
        in: .common
      )
      .autoconnect()
    }

    public var body: some View {
      HStack(spacing: 5) {
        ForEach(0 ..< 3) { index in
          Circle()
            .fill(self.color)
            .frame(width: 10, height: 10)
            .opacity(self.currentIndex == index ? 1.0 : 0.3)
        }
      }
      .onReceive(self.timer) { _ in
        withAnimation {
          self.currentIndex = (self.currentIndex + 1) % 3
        }
      }
    }
  }
}

// MARK: - Preview

struct BlinkingEllipsis_Previews: PreviewProvider {
  static var previews: some View {
    PixelKit.Animations.BlinkingEllipsis(color: Color.yellow, interval: 0.2)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
