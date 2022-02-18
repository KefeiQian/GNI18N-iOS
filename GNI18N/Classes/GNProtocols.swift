//
//  GNProtocols.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/9.
//

import SwiftyUserDefaults

public struct GNI18NLang: Hashable, Codable, Equatable, DefaultsSerializable {
  let name: String

  public init(langName: String) {
    self.name = langName
  }

  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.name == rhs.name
  }
}

public struct GNI18NOptions {
  var lang = GNConstants.DEFAULT_LANG
}
