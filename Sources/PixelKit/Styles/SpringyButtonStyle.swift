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
    private let width: CGFloat

    /// The height of the button.
    private let height: CGFloat

    /// The corner radius of the button.
    private let cornerRadius: CGFloat

    /// The color of the button when enabled.
    private let color: Color

    /// Whether or not the button is disabled.
    private let disabled: Bool

    /// Initializes a new `SpringyButtonStyle` button style.
    ///
    /// - Parameters:
    ///   - width: The width of the button.
    ///   - height: The height of the button.
    ///   - cornerRadius: The corner radius of the button.
    ///   - color: The color of the button.
    ///   - disabled: Whether or not the button is disabled.
    public init(
      width: CGFloat,
      height: CGFloat,
      cornerRadius: CGFloat,
      color: Color,
      disabled: Bool = false
    ) {
      self.width = width
      self.height = height
      self.cornerRadius = cornerRadius
      self.color = color
      self.disabled = disabled
    }

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

// MARK: - Preview

struct SpringyButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    let width: CGFloat = 100
    let height: CGFloat = 50
    let cornerRadius: CGFloat = 10
    let color: Color = .green

    VStack(spacing: 25) {
      ForEach([false, true], id: \.self) { isDisabled in
        Button(isDisabled ? "Disabled" : "Enabled") {}
          .buttonStyle(
            PixelKit.Styles.SpringyButtonStyle(
              width: width,
              height: height,
              cornerRadius: cornerRadius,
              color: color,
              disabled: isDisabled
            )
          )
      }
    }
    .previewLayout(.sizeThatFits)
    .padding()
  }
}
