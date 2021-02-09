//
//  SearchBar.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 12/11/20.
//

import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// House the UISearchController instance, and listen to its changes
public final class SearchBar: NSObject {
  @Binding var text: String
  @Binding var isEditing: Bool
  
  private let canEdit: Bool
  private var didClickSearchButton: (() -> Void)?
  
  public let searchController: UISearchController = UISearchController(
    searchResultsController: nil
  )
  
  public init(
    canEdit: Bool = true,
    text: Binding<String> = .constant(""),
    isEditing: Binding<Bool> = .constant(false),
    didClickSearchButton: (() -> Void)? = nil
  ) {
    _text = text
    _isEditing = isEditing
    self.canEdit = canEdit
    super.init()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.delegate = self
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.obscuresBackgroundDuringPresentation = false
    self.didClickSearchButton = didClickSearchButton
  }
}

extension SearchBar: UISearchBarDelegate, UISearchControllerDelegate {
  public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    isEditing.toggle()
    return canEdit
  }
  
  public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    isEditing = false
  }
  
  public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    return true
  }
  
  public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard isEditing,
          let didClickSearchButton = didClickSearchButton
    else { return }
    didClickSearchButton()
    self.isEditing = false
  }
  
  public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    isEditing = true
  }
}


extension SearchBar: UISearchResultsUpdating {
  public func updateSearchResults(
    for searchController: UISearchController
  ) {
    guard let searchText = searchController.searchBar.text
    else { return }
    text = searchText
  }
}
