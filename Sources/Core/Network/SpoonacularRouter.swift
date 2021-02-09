//
//  File.swift
//  
//
//  Created by Abhijana Agung Ramanda on 06/01/21.
//

import Alamofire
import Foundation

// Sign up to get your own API key
// https://spoonacular.com/food-api/console#Dashboard

public enum SpoonacularRouter: URLRequestConvertible,
                               URLConvertible {
  enum Constants {
    static let apiKey = "2d8e329101664984b9dad8c705e9941a"
    static let baseURLPath = "https://api.spoonacular.com"
  }
  
  case listByName(_ queryName: String, offset: Int)
  case listByCuisine(_ cuisine: String, offset: Int)
  case detail(_ recipeId: String)
  case autocomplete(_ query: String)
  case classify
  
  var method: HTTPMethod {
    switch self {
    case .classify:
      return .post
    default:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .detail(let id):
      return "/recipes/\(id)/information"
    case .autocomplete:
      return "/recipes/autocomplete"
    case .classify:
      return "/food/images/classify"
    default:
      return "/recipes/complexSearch"
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case .detail:
      return ["apiKey": Constants.apiKey, "includeNutrition": "true"]
    case .autocomplete(let query):
      return ["apiKey": Constants.apiKey, "query": query]
    case .listByName(let name, let offset):
      return ["apiKey": Constants.apiKey, "query": name]
        .merging(
          recipeListParameters(offset: offset)
        ) { $1 }
    case .listByCuisine(let cuisine, let offset):
      return ["apiKey": Constants.apiKey, "cuisine": cuisine]
        .merging(
          recipeListParameters(offset: offset)
        ) { $1 }
    default:
      return ["apiKey": Constants.apiKey]
    }
  }
  
  public func asURLRequest() throws -> URLRequest {
    let url = try Constants.baseURLPath.asURL()
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    request.timeoutInterval = TimeInterval(10*1000)
    return try URLEncoding.default.encode(request, with: parameters)
  }
  
  public func asURL() throws -> URL {
    var url = try Constants.baseURLPath.asURL().appendingPathComponent(path)
    parameters.forEach {
      url = url.appending($0.key, value: $0.value as? String)
    }
    return url
  }
}

extension SpoonacularRouter {
  private func recipeListParameters(offset: Int) -> [String: String] {
    [
      "addRecipeNutrition": "true",
      "fillIngredients": "true",
      "offset": "\(offset)"
    ]
  }
}

extension URL {
  func appending(_ queryItem: String, value: String?) -> Self {
    guard var urlComponents = URLComponents(string: absoluteString)
    else { return absoluteURL }
    var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
    let queryItem = URLQueryItem(name: queryItem, value: value)
    queryItems.append(queryItem)
    urlComponents.queryItems = queryItems
    return urlComponents.url ?? self
  }
}
