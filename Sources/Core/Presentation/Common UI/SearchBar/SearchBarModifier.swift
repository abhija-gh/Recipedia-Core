//
//  SearchBarModifier.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 12/11/20.
//

import SwiftUI

// Wrapping up the implementation details into ViewModifier
struct SearchBarModifier: ViewModifier {
  let searchBar: SearchBar
  let hidesSearchBarWhenScrolling: Bool
  let becomeFirstResponder: Bool
  func body(content: Content) -> some View {
    content.overlay(
      ViewControllerResolver { controller in
        if becomeFirstResponder {
          DispatchQueue.main.async {
            self.searchBar.searchController.searchBar.becomeFirstResponder()
          }
        }
        controller.navigationItem.searchController = searchBar.searchController
        controller.navigationItem.hidesSearchBarWhenScrolling = hidesSearchBarWhenScrolling
      }
      .frame(width: 0, height: 0)
    )
  }
}

extension View {
  public func addSearchBar(
    _ searchBar: SearchBar,
    hideWhenScrolling: Bool,
    becomeFirstResponder: Bool = false
  ) -> some View {
    self.modifier(
      SearchBarModifier(
        searchBar: searchBar,
        hidesSearchBarWhenScrolling: hideWhenScrolling,
        becomeFirstResponder: becomeFirstResponder
      )
    )
  }
}
