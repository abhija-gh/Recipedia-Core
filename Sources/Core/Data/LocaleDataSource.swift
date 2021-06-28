//
//  LocaleDataSource.swift
//  
//
//  Created by Abhijana Agung Ramanda on 28/12/20.
//

import Foundation
import Combine

public protocol LocaleDataSource: AnyObject {
  associatedtype Request
  associatedtype Response
  
  func getList(request: Request?) -> AnyPublisher<[Response], Error>
  func addEntity(_ entity: Response) -> AnyPublisher<Bool, Error>
  func deleteEntity(byId entityId: Int) -> AnyPublisher<Bool, Error>
  func checkExistence(of entity: Response) -> AnyPublisher<Bool, Error>
}
