//
//  ListPresenterProtocol.swift
//  
//
//  Created by Abhijana Agung Ramanda on 06/01/21.
//

import Foundation
import Combine

public protocol ListPresenterProtocol: class {
  associatedtype Request
  associatedtype Response
  associatedtype Interactor
  
  var list: [Response] { get set }
  var state: PresenterState { get set }
  var isSearching: Bool { get set }
  
  func getList(request: Request)
}

public enum RecipeListParameter {
  case local
  case name(_ name: String)
}
