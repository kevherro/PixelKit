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

extension PixelKit.Styles {
  /// A custom button style that provides a springy,
  /// 3D-like effect for visual feedback.
  ///
  /// `SpringyButtonStyle` creates buttons with a depth effect,
  /// giving them a raised appearance when idle and a pressed-down look when held.
  /// This style is designed to provide clear visual feedback for user interactions.
  ///
  /// Example usage:
  /// ```swift
  /// Button("Press Me") {
  ///   print("Button pressed!")
  /// }
  /// .buttonStyle(
  ///   SpringyButtonStyle(
  ///     width: 200,
  ///     height: 50,
  ///     cornerRadius: 10,
  ///     color: .blue
  ///   )
  /// )
  /// ```
  public struct SpringyButtonStyle: PrimitiveButtonStyle {
    /// Whether or not the button is currently being held.
    @State private var isHeld = false

    /// The width of the button.
    let width: CGFloat

    /// The height of the button.
    let height: CGFloat

    /// The corner radius of the button.
    let cornerRadius: CGFloat

    /// The color of the button when enabled.
    let color: Color

    /// Whether or not the button is disabled.
    let disabled: Bool

    public func makeBody(configuration: Configuration) -> some View {
      self.buttonContent(configuration: configuration)
        .gesture(
          DragGesture(minimumDistance: 0)
            .onChanged { _ in self.isHeld = !self.disabled }
            .onEnded { _ in
              if !self.disabled {
                self.isHeld = false
                configuration.trigger()
              }
            }
        )
    }

    private func buttonContent(configuration: Configuration) -> some View {
      ZStack {
        self.buttonShape
          .fill(self.fillColor)
          .frame(width: self.width, height: self.height)
          .overlay(self.buttonShape.stroke(self.strokeColor, lineWidth: 1))
          .overlay(self.buttonLabel(configuration: configuration))
          .offset(y: self.offsetY)
          .zIndex(1)

        self.buttonShape
          .fill(self.shadowColor)
          .frame(width: self.width, height: self.height)
      }
    }

    private var buttonShape: some Shape {
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
    }

    private func buttonLabel(configuration: Configuration) -> some View {
      configuration.label
        .foregroundStyle(.white)
        .font(.headline)
        .fontDesign(.rounded)
        .fontWeight(.semibold)
        .foregroundColor(self.disabled ? .gray : .white)
    }

    private var fillColor: Color {
      self.disabled ? .gray : self.color
    }

    private var strokeColor: Color {
      self.disabled ? .gray : self.color
    }

    private var shadowColor: Color {
      self.disabled ? .gray : self.color.opacity(0.8)
    }

    private var offsetY: CGFloat {
      self.disabled ? 0 : (self.isHeld ? 0 : -3.8)
    }
  }
}
