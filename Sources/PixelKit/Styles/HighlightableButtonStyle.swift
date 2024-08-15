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
  /// A button style that becomes highlighted when tapped.
  ///
  /// This style provides visual feedback by changing the button's background
  /// color when tapped once.
  /// It also includes a spring animation for a more dynamic feel.
  ///
  /// Example usage:
  /// ```swift
  /// @State var isSelected = false
  /// let size: CGSize = CGSizeMake(width: 200, height: 50)
  ///
  /// Button("Press Me") {
  ///   print("Button pressed!")
  /// }
  /// .buttonStyle(
  ///   HighlightableButtonStyle(
  ///     isSelected: $isSelected,
  ///     size: size,
  ///     cornerRadius: 10,
  ///     color: .blue,
  ///     backgroundColor: .black
  ///   )
  /// )
  /// ```
  public struct HighlightableButtonStyle: PrimitiveButtonStyle {
    /// Tracks whether the button is selected.
    /// This is a binding to allow external control of the button.
    @Binding var isSelected: Bool

    /// The size of the button.
    /// This determines both the width and height of the button.
    private let size: CGSize

    /// The corner radius of the button.
    private let cornerRadius: CGFloat

    /// The color of the button.
    private let color: Color

    /// The color of the View's background.
    private let backgroundColor: Color

    /// Indicates whether the button is in a disabled state.
    private let isDisabled: Bool

    /// Tracks whether the button is currently being pressed.
    @State private var isPressed = false

    /// Initializes a new `HighlightableButtonStyle` style.
    ///
    /// - Parameters:
    ///   - isSelected: A binding to whether the button is currently selected.
    ///   - size: The size of the button.
    ///   - cornerRadius: The corner radius of the button.
    ///   - color: The color of the button.
    ///   - backgroundColor: The color of the parent View's background.
    ///   - isDisabled: Whether or not the button is disabled. Defaults to
    /// `false`.
    public init(
      isSelected: Binding<Bool>,
      size: CGSize,
      cornerRadius: CGFloat,
      color: Color,
      backgroundColor: Color,
      isDisabled: Bool = false
    ) {
      self._isSelected = isSelected
      self.size = size
      self.cornerRadius = cornerRadius
      self.color = color
      self.backgroundColor = backgroundColor
      self.isDisabled = isDisabled
    }

    public func makeBody(configuration: Configuration) -> some View {
      ZStack {
        self.buttonBackground(color: self.backgroundColor, offset: self.offsetY)
          .zIndex(1)
        self.buttonForeground(configuration: configuration)
          .zIndex(1)
        self.buttonBackground(color: self.isDisabled ? .gray : self.color)
      }
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged { _ in
            if !self.isDisabled {
              self.isPressed = true
            }
          }
          .onEnded { _ in
            if !self.isDisabled {
              self.isPressed = false
              self.isSelected.toggle()
              configuration.trigger()
            }
          }
      )
    }

    private var fillColor: Color {
      self
        .isDisabled ? .gray :
        (self.isSelected ? self.color.opacity(0.3) : self.backgroundColor)
    }

    private var offsetY: CGFloat {
      self.isDisabled ? 0 : (self.isPressed ? 0 : -3.8)
    }

    private func buttonBackground(
      color: Color,
      offset: CGFloat = 0
    ) -> some View {
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
        .fill(color)
        .stroke(self.isDisabled ? .gray : color, lineWidth: 1)
        .frame(width: self.size.width, height: self.size.height)
        .offset(y: offset)
    }

    private func buttonForeground(configuration: Configuration) -> some View {
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
        .fill(self.fillColor)
        .stroke(self.isDisabled ? .gray : self.color, lineWidth: 3)
        .frame(width: self.size.width, height: self.size.height)
        .overlay(
          configuration.label
            .foregroundColor(self.isSelected ? self.color : .white)
        )
        .offset(y: self.offsetY)
    }
  }
}
