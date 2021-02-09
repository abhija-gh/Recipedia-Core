//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 14/01/21.
//

import Foundation

public enum PresenterState {
  case loading
  case error(_ message: String)
  case populated
  case empty
}
