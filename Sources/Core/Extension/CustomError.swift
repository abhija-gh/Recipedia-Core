//
//  CustomError.swift
//  
//
//  Created by Abhijana Agung Ramanda on 28/12/20.
//

import Foundation

public enum DatabaseError: LocalizedError {
  case invalidInstance
  case requestFailed
  
  public var errorDescription: String? {
    switch self {
    case .invalidInstance:
      return "Cannot create db instance."
    case .requestFailed:
      return "Your request has failed."
    }
  }
  
}
