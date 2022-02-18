//
//  HomeView.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/8.
//

import GNI18N
import SwiftUI

let name = "KQ"

private class HomeViewText: GNText {
  @Published var helloTitle: String!
  @Published var nameText: String!
  @Published var changeLanguageText: String!

  override init() {
    super.init()
    self.updateText()
  }

  override func updateText() {
    self.helloTitle = GNI18N.getLocalizedText(key: "hello-title")
    self.nameText = String.localizedStringWithFormat(
      GNI18N.getLocalizedText(key: "name %@"), name)
    self.changeLanguageText = GNI18N.getLocalizedText(key: "change-language-button")
  }
}

struct HomeView: View {
  @ObservedObject fileprivate var text = HomeViewText()

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text(text.helloTitle).padding(20)

        Text(text.nameText).padding(20)

        Button(text.changeLanguageText) {
          GNI18N.shared.changeLanguage(lang: getRandomLangExceptCurrentLang())
        }
        .padding(20)
      }
      .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .edgesIgnoringSafeArea(.all)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView().environment(\.locale, .init(identifier: "en"))

    HomeView().environment(\.locale, .init(identifier: "zh-Hans"))

    HomeView().environment(\.locale, .init(identifier: "ja-JP"))
  }
}
