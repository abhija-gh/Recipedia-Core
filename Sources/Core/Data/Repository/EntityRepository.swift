//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 07/01/21.
//

import Combine

public protocol EntityRepository: Repository {
  func addEntity(_ entity: Response) -> AnyPublisher<Bool, Error>
  func deleteEntity(byId entityId: Request) -> AnyPublisher<Bool, Error>
  func checkExistence(of entity: Response) -> AnyPublisher<Bool, Error>
}
