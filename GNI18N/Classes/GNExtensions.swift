//
//  GNNotification.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/9.
//

import SwiftUI
import SwiftyUserDefaults

extension Notification.Name {
  public static let GN_LANGUAGE_CHANGED = Notification.Name("GN_LANGUAGE_CHANGED")
}

var bundleKey: UInt8 = 0

class AnyLanguageBundle: Bundle {
  override func localizedString(
    forKey key: String,
    value: String?,
    table tableName: String?
  ) -> String {

    guard let path = objc_getAssociatedObject(self, &bundleKey) as? String,
      let bundle = Bundle(path: path)
    else {
      return super.localizedString(forKey: key, value: value, table: tableName)
    }

    return bundle.localizedString(forKey: key, value: value, table: tableName)
  }
}

extension Bundle {
  class func setLanguage(_ language: GNI18NLang) {
    defer {
      object_setClass(Bundle.main, AnyLanguageBundle.self)
    }
    objc_setAssociatedObject(
      Bundle.main, &bundleKey, Bundle.main.path(forResource: language.name, ofType: "lproj"),
      .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
  }
}

extension DefaultsKeys {
  var storedLanguage: DefaultsKey<GNI18NLang> {
    .init("storedLanguage", defaultValue: GNConstants.DEFAULT_LANG)
  }
}
