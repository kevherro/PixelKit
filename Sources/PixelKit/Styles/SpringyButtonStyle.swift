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
  /// giving a raised appearance when idle and a pressed-down look when held.
  /// This style is designed to provide clear visual feedback for user
  /// interactions.
  ///
  /// Example usage:
  /// ```swift
  /// let size: CGSize = CGSizeMake(width: 200, height: 50)
  ///
  /// Button("Press Me") {
  ///   print("Button pressed!")
  /// }
  /// .buttonStyle(
  ///   SpringyButtonStyle(
  ///     size: size,
  ///     cornerRadius: 10,
  ///     color: .blue
  ///   )
  /// )
  /// ```
  public struct SpringyButtonStyle: PrimitiveButtonStyle {
    /// Whether or not the button is currently being held.
    @State private var isHeld = false

    /// The size of the button.
    /// This determines both the width and height of the button.
    private let size: CGSize

    /// The corner radius of the button.
    private let cornerRadius: CGFloat

    /// The color of the button when enabled.
    private let color: Color

    /// Whether or not the button is disabled.
    private let isDisabled: Bool

    /// Initializes a new `SpringyButtonStyle` style.
    ///
    /// - Parameters:
    ///   - size: The size of the button.
    ///   - cornerRadius: The corner radius of the button.
    ///   - color: The color of the button.
    ///   - isDisabled: Whether or not the button is disabled. Defaults to
    /// `false`.
    public init(
      size: CGSize,
      cornerRadius: CGFloat,
      color: Color,
      isDisabled: Bool = false
    ) {
      self.size = size
      self.cornerRadius = cornerRadius
      self.color = color
      self.isDisabled = isDisabled
    }

    public func makeBody(configuration: Configuration) -> some View {
      self.buttonContent(configuration: configuration)
        .gesture(
          DragGesture(minimumDistance: 0)
            .onChanged { _ in self.isHeld = !self.isDisabled }
            .onEnded { _ in
              if !self.isDisabled {
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
          .frame(width: self.size.width, height: self.size.height)
          .overlay(self.buttonShape.stroke(self.fillColor, lineWidth: 1))
          .overlay(self.buttonLabel(configuration: configuration))
          .offset(y: self.offsetY)
          .zIndex(1)

        self.buttonShape
          .fill(self.shadowColor)
          .frame(width: self.size.width, height: self.size.height)
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
        .foregroundColor(self.isDisabled ? .gray : .white)
    }

    private var fillColor: Color {
      self.isDisabled ? .gray : self.color
    }

    private var shadowColor: Color {
      self.isDisabled ? .gray : self.color.opacity(0.8)
    }

    private var offsetY: CGFloat {
      self.isDisabled ? 0 : (self.isHeld ? 0 : -3.8)
    }
  }
}
