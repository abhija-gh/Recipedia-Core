//
//  DataSource.swift
//  
//
//  Created by Abhijana Agung Ramanda on 28/12/20.
//

import Foundation
import Combine

public protocol DataSource: class {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
