//
//  ExpandableTextView.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 13/11/20.
//

import SwiftUI

public struct ExpandableTextView: View {
  @State private var expanded = false
  @State private var truncated = false
  
  private var text: String
  
  public var toggleButton: some View {
    Button(
      action: {
        withAnimation {
          self.expanded.toggle()
        }
      },
      label: {
        Text(self.expanded ? "Show less" : "Show more")
          .font(.caption)
      }
    )
    .foregroundColor(.purple)
  }
  
  public init(text: String) {
    self.text = text
  }
  
  private func checkTruncation(_ geometry: GeometryProxy) {
    let boundingBox = text.boundingRect(
      with: CGSize(
        width: geometry.size.width,
        height: .greatestFiniteMagnitude
      ),
      options: .usesLineFragmentOrigin,
      attributes: [.font: UIFont.systemFont(ofSize: 16)],
      context: nil
    )
    if boundingBox.size.height > geometry.size.height {
      truncated = true
    }
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(text)
        .font(.system(size: 16))
        .lineLimit(expanded ? nil : 3)
        .background(GeometryReader { geometry in
          Color.clear.onAppear {
            self.checkTruncation(geometry)
          }
        })
      if truncated { self.toggleButton }
    }
  }
}
