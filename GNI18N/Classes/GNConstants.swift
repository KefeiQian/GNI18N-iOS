//
//  GNConstants.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/9.
//

public struct GNConstants {
  public static let DEFAULT_LANG = GNI18NLang(
    langName: Locale.autoupdatingCurrent.languageCode ?? Locale.current.languageCode ?? "en")

  public static let LANG_KEY = "lang"
  public static let BRIDGE_KEY = "bridge"

  public static let CHANGE_LANGUAGE_NATIVE_BRIDGE_NAME = "changeLanguageNative"
  public static let CHANGE_LANGUAGE_WEB_BRIDGE_NAME = "changeLanguageWeb"
  public static let GET_NATIVE_LANG_BRIDGE_NAME = "getNativeLanguage"
}
