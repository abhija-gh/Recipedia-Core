//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 27/01/21.
//

import Foundation
import Combine

public protocol RemoteUseCase: UseCase {
  associatedtype Status
  func getCurrentNetworkStatus() -> AnyPublisher<Status, Never>
}

public class RemoteInteractor<Request, Response, R: Repository>: RemoteUseCase
where
  R.Request == Request,
  R.Response == Response
{
  public typealias Status = NetworkStatus
  
  private var repository: R
  private var reachability: NetworkReachability
  
  public init(repository: R, reachability: NetworkReachability) {
    self.repository = repository
    self.reachability = reachability
    reachability.startNetworkMonitoring()
  }
  
  public func execute(request: Request) -> AnyPublisher<Response, Error> {
    return repository.execute(request: request)
  }
  
  public func getCurrentNetworkStatus() -> AnyPublisher<NetworkStatus, Never> {
    reachability
      .publisher(for: \.networkStatus, options: [.new])
      .eraseToAnyPublisher()
  }
}
