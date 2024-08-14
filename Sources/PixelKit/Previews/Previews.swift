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
