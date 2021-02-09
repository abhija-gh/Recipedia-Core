//
//  String+withoutHtml.swift
//  Recipedia
//
//  Created by Abhijana Agung Ramanda on 15/11/20.
//

import Foundation

extension String {
  public var withoutHtmlTags: String {
    self
      .replacingOccurrences(
        of: "<[^>]+>",
        with: "",
        options: .regularExpression,
        range: nil
      )
      .replacingOccurrences(
        of: "&[^;]+;",
        with: "",
        options: .regularExpression,
        range: nil
      )
  }
}
