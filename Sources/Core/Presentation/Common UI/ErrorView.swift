//
//  ErrorView.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 04/12/20.
//

import SwiftUI

public func makeErrorView(with errorMessage: String) -> some View {
  Text(errorMessage)
    .multilineTextAlignment(.center)
    .foregroundColor(.red)
    .padding(.horizontal)
}
