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
  /// A button style that becomes highlighted when tapped once.
  ///
  /// This style provides visual feedback by changing the button's background color when tapped
  /// once.
  /// It also includes a spring animation for a more dynamic feel.
  ///
  /// Example usage:
  /// ```swift
  /// @State var hasBeenPressed = false
  ///
  /// Button("Press Me") {
  ///   print("Button pressed!")
  /// }
  /// .buttonStyle(
  ///   HighlightableButtonStyle(
  ///     width: 200,
  ///     height: 50,
  ///     cornerRadius: 10,
  ///     color: .blue,
  ///     backgroundColor: .black,
  ///     hasBeenPressed: $hasBeenPressed
  ///   )
  /// )
  /// ```
  public struct HighlightableButtonStyle: PrimitiveButtonStyle {
    /// The width of the button.
    let width: CGFloat

    /// The height of the button.
    let height: CGFloat

    /// The corner radius of the button.
    let cornerRadius: CGFloat

    /// The color of the button.
    let color: Color

    /// The color of the View's background.
    /// These must match.
    let backgroundColor: Color

    /// Tracks whether the button has ever been pressed.
    /// This is a binding to allow external control of the button.
    @Binding var hasBeenPressed: Bool

    /// Indicates whether the button is in a disabled state.
    let disabled: Bool

    /// Tracks whether the button is currently being pressed.
    @State private var isPressed = false

    public func makeBody(configuration: Configuration) -> some View {
      ZStack {
        self.buttonBackground(color: self.backgroundColor, offset: self.offsetY)
          .zIndex(1)
        self.buttonForeground(configuration: configuration)
          .zIndex(1)
        self.buttonBackground(color: self.disabled ? .gray : self.color)
      }
      .gesture(
        DragGesture(minimumDistance: 0)
          .onChanged { _ in
            if !self.disabled {
              self.isPressed = true
            }
          }
          .onEnded { _ in
            if !self.disabled {
              self.isPressed = false
              self.hasBeenPressed = true
              configuration.trigger()
            }
          }
      )
    }

    private var fillColor: Color {
      self.disabled ? .gray : (self.hasBeenPressed ? self.color.opacity(0.3) : self.backgroundColor)
    }

    private var offsetY: CGFloat {
      self.disabled ? 0 : (self.isPressed ? 0 : -3.8)
    }

    private func buttonBackground(color: Color, offset: CGFloat = 0) -> some View {
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
        .fill(color)
        .stroke(self.disabled ? .gray : color, lineWidth: 1)
        .frame(width: self.width, height: self.height)
        .offset(y: offset)
    }

    private func buttonForeground(configuration: Configuration) -> some View {
      RoundedRectangle(cornerRadius: self.cornerRadius, style: .continuous)
        .fill(self.fillColor)
        .stroke(self.disabled ? .gray : self.color, lineWidth: 3)
        .frame(width: self.width, height: self.height)
        .overlay(
          configuration.label
            .foregroundColor(self.hasBeenPressed ? self.color : .white)
        )
        .offset(y: self.offsetY)
    }
  }
}

// MARK: - Preview

private struct HighlightableButtonStyle_Preview: View {
  /// Tracks whether the button has ever been pressed.
  @State private var hasBeenPressed: Bool = false

  /// Indicates whether the button is in a disabled state.
  let disabled: Bool

  var body: some View {
    Button(self.disabled ? "Disabled" : "Enabled") {}
      .buttonStyle(
        PixelKit.Styles.HighlightableButtonStyle(
          width: 200,
          height: 40,
          cornerRadius: 10,
          color: .cyan,
          backgroundColor: .black,
          hasBeenPressed: self.$hasBeenPressed,
          disabled: self.disabled
        )
      )
  }
}

#Preview {
  ZStack {
    Color.black.ignoresSafeArea()
    VStack(spacing: 50) {
      HighlightableButtonStyle_Preview(disabled: false)
      HighlightableButtonStyle_Preview(disabled: true)
    }
  }
}
