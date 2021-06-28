//
//  RemoteDataSource.swift
//  
//
//  Created by Abhijana Agung Ramanda on 02/01/21.
//

import Foundation
import Combine

public protocol RemoteDataSource: AnyObject {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request) -> AnyPublisher<Response, Error>
}
