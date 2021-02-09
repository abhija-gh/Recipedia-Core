//
//  NetworkClient.swift
//  
//
//  Created by Abhijana Agung Ramanda on 06/01/21.
//

import Foundation
import Alamofire

public struct NetworkClient {
  public static let shared: (Session) -> NetworkClient = {
    NetworkClient($0)
  }
  
  private let session: Session
  
  private init(_ session: Session) {
    self.session = session
  }
  
  public func request(
    _ convertible: URLRequestConvertible
  ) -> DataRequest {
    session.request(convertible).validate()
  }
  
  public func upload(
    multipartFormData: @escaping (MultipartFormData) -> Void,
    with convertible: URLRequestConvertible
  ) -> UploadRequest {
    session
      .upload(
        multipartFormData: multipartFormData,
        with: convertible
      ).validate()
  }
  
  public func upload(
    multipartFormData: @escaping (MultipartFormData) -> Void,
    to convertible: URLConvertible
  ) -> UploadRequest {
    let headers: HTTPHeaders = [
      "Content-type": "multipart/form-data",
      "Content-Disposition" : "form-data"
    ]
    return session
      .upload(
        multipartFormData: multipartFormData,
        to: convertible,
        method: .post,
        headers: headers
      )
  }
}
