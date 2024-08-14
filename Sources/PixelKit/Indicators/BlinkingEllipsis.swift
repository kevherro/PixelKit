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

extension PixelKit.Indicators {
  /// A view that displays a blinking ellipsis animation.
  ///
  /// `BlinkingEllipsis` creates an animated ellipsis effect using three circles that
  /// blink in sequence.
  /// This can be useful for indicating loading states,
  /// ongoing processes, or any scenario where a subtle,
  /// repeating animation is desired.
  ///
  /// Example usage:
  /// ```swift
  /// BlinkingEllipsis(color: .blue, interval: 0.5)
  /// ```
  public struct BlinkingEllipsis: View {
    /// The current index of the circle that should be fully opaque.
    @State private var currentIndex = 0

    /// The color of the blinking circles.
    private let color: Color

    /// The timer that drives the animation,
    /// determining how frequently the circles blink.
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    /// Initializes a new `BlinkingEllipsis`.
    ///
    /// - Parameters:
    ///   - color: The color of the blinking circles
    ///   - interval: The time interval between each blink, in seconds.
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
