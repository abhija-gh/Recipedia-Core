//
//  LoadingView.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 04/12/20.
//

import SwiftUI
import ActivityIndicatorView

public var loadingView: some View {
  VStack {
    ActivityIndicatorView(
      isVisible: .constant(true),
      type: .opacityDots
    )
    .frame(width: 50, height: 50)
    Text("Loading...")
      .accessibility(identifier: "loading")
  }
  .frame(width: 100, height: 100)
  .foregroundColor(Color(#colorLiteral(red: 0.0431372549, green: 0.5176470588, blue: 0.3411764706, alpha: 1)))
  .background(Color.gray.opacity(0.15))
  .cornerRadius(8)
}
