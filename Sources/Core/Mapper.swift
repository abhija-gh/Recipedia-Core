//
//  Mapper.swift
//  
//
//  Created by Abhijana Agung Ramanda on 28/12/20.
//

import Foundation

public protocol Mapper {
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func mapResponseToDomain(_ response: Response) -> Domain
  func mapEntityToDomain(_ entity: Entity) -> Domain
  func mapDomainToEntity(_ domain: Domain) -> Entity
}
