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

extension PixelKit.Indicators {
  /// A customizable progress bar that visually represents progress through a series of
  /// steps.
  ///
  /// `ProgressBar` provides a simple, animated way to show progress in your app.
  /// It's highly customizable, allowing you to set the color, size, and number of steps.
  ///
  /// Example usage:
  /// ```swift
  /// @State private var currentStep = 0
  /// let totalSteps = 5
  ///
  /// ProgressBar(
  ///   currentStep: $currentStep,
  ///   totalSteps: totalSteps,
  ///   color: .blue,
  ///   size: CGSize(width: 200, height: 10)
  /// )
  /// ```
  public struct ProgressBar: View {
    /// The current step in the progress sequence.
    /// This is a binding to allow external control of the progress.
    @Binding var currentStep: Int

    /// The total number of steps in the progress sequence.
    /// This determines when the progress bar is considered complete.
    let totalSteps: Int

    /// The color of the progress indicator.
    /// The background will be a gray version of this color.
    let color: Color

    /// The size of the progress bar.
    /// This determines both the width and height of the bar.
    let size: CGSize

    public var body: some View {
      ZStack(alignment: .leading) {
        Capsule()
          .fill(.gray)

        Capsule()
          .fill(self.color)
          .frame(width: self.progressWidth)
          .animation(
            .spring(response: 0.1, dampingFraction: 1.0, blendDuration: 0.6),
            value: self.currentStep
          )
      }
      .frame(width: self.size.width, height: self.size.height)
    }

    private var progressWidth: CGFloat {
      let progress = CGFloat(currentStep) / CGFloat(max(1, self.totalSteps - 1))
      return progress * self.size.width
    }
  }
}
