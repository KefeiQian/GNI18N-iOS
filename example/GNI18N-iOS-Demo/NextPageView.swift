//
// Created by Kefei Qian on 2022/2/10.
//

import GNI18N
import SwiftUI

private class NextPageViewText: GNText {
  @Published var changeLanguageText: String!
  @Published var nextPageViewTitle: String!
  @Published var backButtonText: String!

  override init() {
    super.init()
    self.updateText()
  }

  override func updateText() {
    self.nextPageViewTitle = GNI18N.getLocalizedText(key: "second-view-title")
    self.changeLanguageText = GNI18N.getLocalizedText(key: "change-language-button")
    self.backButtonText = GNI18N.getLocalizedText(key: "back-button")
  }
}

struct NextPageView: View {
  @Environment(\.presentationMode) var presentationMode
  @ObservedObject fileprivate var text = NextPageViewText()

  var body: some View {
    VStack(alignment: .center) {
      Text(text.nextPageViewTitle).padding(20)

      Button(text.changeLanguageText) {
        GNI18N.shared.changeLanguage(lang: getRandomLangExceptCurrentLang())
      }
      .padding(20)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .edgesIgnoringSafeArea(.all)
    .navigationBarItems(
      leading:
        Button(action: {
          presentationMode.wrappedValue.dismiss()
        }) {
          HStack(alignment: .center) {
            Image(systemName: "chevron.backward")
            Text(text.backButtonText)
          }
        }
    )
    .navigationBarBackButtonHidden(true)
  }
}
