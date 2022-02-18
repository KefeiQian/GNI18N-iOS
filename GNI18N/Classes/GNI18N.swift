//
//  GNI18N.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/8.
//

import SwiftyUserDefaults
import WKWebViewJavascriptBridge
import WebKit

public class GNI18N {
  public static let shared = GNI18N()

  public private(set) var currentLang: GNI18NLang

  private var bridges = [WKWebViewJavascriptBridge]()

  private var hasSetWebviewNotification = false

  private init() {
    self.currentLang = Defaults[\.storedLanguage]
  }

  public static func setup() {
    if shared.currentLang != GNConstants.DEFAULT_LANG {
      shared.changeLanguage(lang: shared.currentLang)
    }
  }

  public func changeLanguage(lang: GNI18NLang) {
    self.currentLang = lang
    Defaults[\.storedLanguage] = currentLang

    Bundle.setLanguage(lang)

    NotificationCenter.default.post(
      name: .GN_LANGUAGE_CHANGED, object: nil, userInfo: [GNConstants.LANG_KEY: lang])
  }

  public static func getLocalizedText(key: String) -> String {
    return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
  }

  public static func getLocalizedText(key: String, table tableName: String? = nil) -> String {
    return Bundle.main.localizedString(forKey: key, value: nil, table: tableName)
  }

  public func bindWebview(_ webView: WKWebView) -> WKWebViewJavascriptBridge {
    let bridge = WKWebViewJavascriptBridge(webView: webView)
    //    bridge.isLogEnable = true
    self.bridges.append(bridge)

    if !self.hasSetWebviewNotification {
      self.hasSetWebviewNotification = true
      NotificationCenter.default.addObserver(
        self, selector: #selector(GNI18N.updateWebviewLanguage(_notification:)),
        name: .GN_LANGUAGE_CHANGED, object: nil)
    }

    bridge.register(handlerName: GNConstants.CHANGE_LANGUAGE_WEB_BRIDGE_NAME) {
      (parameters, callback) in
      guard let lang = parameters?[GNConstants.LANG_KEY] else {
        return
      }
      self.changeLanguage(lang: GNI18NLang.init(langName: lang as! String))

      callback?("Native language changed to \(lang)")
    }

    bridge.register(handlerName: GNConstants.GET_NATIVE_LANG_BRIDGE_NAME) { parameters, callback in
      callback?(self.currentLang.name)
    }

    return bridge
  }

  @objc func updateWebviewLanguage(_notification: Notification) {
    guard let userInfo = _notification.userInfo else {
      return
    }

    guard let lang = userInfo[GNConstants.LANG_KEY] as? GNI18NLang else {
      return
    }

    self.bridges.forEach { bridge in
      bridge.call(
        handlerName: GNConstants.CHANGE_LANGUAGE_NATIVE_BRIDGE_NAME,
        data: [GNConstants.LANG_KEY: lang.name])
    }
  }
}
