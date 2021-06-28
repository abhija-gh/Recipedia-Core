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
  
  private init(_ session: Session = .default) {
    self.session = session
  }
  
  public func request<T: Decodable>(
    _ convertible: URLRequestConvertible,
    completion: @escaping (Result<T, AFError>) -> Void
  ) {
    session.request(convertible).validate().responseDecodable(of: T.self) { data in
      setQuota(fromResponse: data.response)
      completion(data.result)
    }
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
  
  public func upload<T: Decodable>(
    multipartFormData: @escaping (MultipartFormData) -> Void,
    to convertible: URLConvertible,
    completion: @escaping (Result<T, AFError>) -> Void
  ) {
    let headers: HTTPHeaders = [
      "Content-type": "multipart/form-data",
      "Content-Disposition" : "form-data"
    ]
    session.upload(
      multipartFormData: multipartFormData,
      to: convertible,
      method: .post,
      headers: headers
    )
    .uploadProgress { progress in
      print("Upload Progress: \(progress.fractionCompleted)")
    }
    .responseDecodable(of: T.self) { data in
      setQuota(fromResponse: data.response)
      completion(data.result)
    }
  }
  
  private func setQuota(fromResponse response: HTTPURLResponse?) {
    if let aHeader = response?.allHeaderFields["x-api-quota-used"] as? String,
       let quotaUsed = Float(aHeader) {
      QuotaManager.shared.set(quotaUsed)
    } else {
      print("Unable to get \"x-api-quota-used\" header field from response")
    }
  }
}
