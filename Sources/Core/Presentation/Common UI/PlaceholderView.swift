//
//  SwiftUIView.swift
//  
//
//  Created by Abhijana Agung Ramanda on 30/01/21.
//

import SwiftUI

public struct PlaceholderView: View {
  public var imageSystemName: String
  public var descriptionText: String
  
  public init(imageSystemName: String, descriptionText: String) {
    self.imageSystemName = imageSystemName
    self.descriptionText = descriptionText
  }
  
  public var body: some View {
    VStack(spacing: 16) {
      Image(systemName: imageSystemName)
        .font(.system(size: 100))
      Text(descriptionText)
    }
    .foregroundColor(Color.gray.opacity(0.5))
  }
}
