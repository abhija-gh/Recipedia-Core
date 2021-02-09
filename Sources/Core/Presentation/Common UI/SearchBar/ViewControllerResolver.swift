//
//  ViewControllerResolver.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 11/11/20.
//

import SwiftUI
import UIKit

final class ParentViewControllerResolver: UIViewController {
  // To hook up the parent VC reference to SwiftUI
  let onResolve: (UIViewController) -> Void
  
  init(onResolve: @escaping (UIViewController) -> Void) {
    self.onResolve = onResolve
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
  }
  
  // We can use this to get a reference to the actual hosting VC of SwiftUI list
  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    guard let parent = parent else { return }
    onResolve(parent)
  }
}

final class ViewControllerResolver: UIViewControllerRepresentable {
  let onResolve: (UIViewController) -> Void
  
  init(onResolve: @escaping (UIViewController) -> Void) {
    self.onResolve = onResolve
  }
  
  // Wraps the parent into swiftUI View
  func makeUIViewController(context: Context) -> ParentViewControllerResolver {
    ParentViewControllerResolver(onResolve: onResolve)
  }
  
  func updateUIViewController(_ uiViewController: ParentViewControllerResolver, context: Context) {}
}
