//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 03/01/21.
//

import Foundation

public class QuotaManager {
  private var _point: Float
  
  private init(point: Float) {
    _point = point
  }
  
  public static let shared: QuotaManager = QuotaManager(point: 0.0)
  
  public var point: Int {
    Int(_point)
  }
  
  public func set(_ point: Float) {
    _point = point
  }
}
