//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 07/01/21.
//

import Combine

public protocol EntityUseCase: UseCase {
  func addEntity(_ entity: Response) -> AnyPublisher<Bool, Error>
  func deleteEntity(byId entityId: Request) -> AnyPublisher<Bool, Error>
  func checkExistence(of entity: Response) -> AnyPublisher<Bool, Error>
}

public class EntityInteractor<Request, Response, R: EntityRepository>: EntityUseCase
where
  R.Request == Request,
  R.Response == Response
{
  private var repository: R
  
  public init(repository: R) {
    self.repository = repository
  }
  
  public func addEntity(_ entity: Response) -> AnyPublisher<Bool, Error> {
    repository.addEntity(entity)
  }
  
  public func deleteEntity(byId entityId: Request) -> AnyPublisher<Bool, Error> {
    repository.deleteEntity(byId: entityId)
  }
  
  public func checkExistence(of entity: Response) -> AnyPublisher<Bool, Error> {
    repository.checkExistence(of: entity)
  }
  
  public func execute(request: Request) -> AnyPublisher<Response, Error> {
    repository.execute(request: request)
  }
  
}
