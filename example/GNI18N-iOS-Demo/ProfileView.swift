//
//  ProfileView.swift
//  swift-ui-demo
//
//  Created by Kefei Qian on 2022/2/8.
//

import GNI18N
import SwiftUI

private class ProfileViewText: GNText {
  @Published var profileTitle: String!
  @Published var nextPage: String!

  override init() {
    super.init()
    self.updateText()
  }

  override func updateText() {
    self.nextPage = GNI18N.getLocalizedText(key: "next-page")
    self.profileTitle = GNI18N.getLocalizedText(key: "profile-tab-title")
  }
}

struct ProfileView: View {
  @ObservedObject fileprivate var text = ProfileViewText()

  var body: some View {
    VStack(alignment: .center) {
      Text(text.profileTitle).padding(20)

      NavigationLink(destination: NextPageView()) {
        Text(text.nextPage)
      }.padding(20)
    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .edgesIgnoringSafeArea(.all)
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
