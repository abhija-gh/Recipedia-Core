//
//  NetworkManager.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 02/12/20.
//

import Foundation
import Alamofire
import Combine

public class NetworkReachability: NSObject {
  private let reachabilityManager: NetworkReachabilityManager?
  @objc dynamic public var networkStatus: NetworkStatus = .online
  
  private init(manager: NetworkReachabilityManager?) {
    reachabilityManager = manager
  }
  
  public static let shared: (NetworkReachabilityManager?) -> NetworkReachability = {
    NetworkReachability(manager: $0)
  }
  
  public func startNetworkMonitoring() {
    reachabilityManager?.startListening { [weak self] status in
      switch status {
      case .reachable(_):
        self?.networkStatus = .online
      case .notReachable, .unknown:
        self?.networkStatus = .offline
      }
    }
  }
}

public class NetworkStatus: NSObject, RawRepresentable {
  public typealias RawValue = String
  public var rawValue: String
  
  public static let online = NetworkStatus(rawValue: "online")
  public static let offline = NetworkStatus(rawValue: "offline")
  
  required public init(rawValue: String) {
    self.rawValue = rawValue
  }
}
