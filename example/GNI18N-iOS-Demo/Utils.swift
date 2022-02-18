//
// Created by Kefei Qian on 2022/2/10.
//

import GNI18N

public func getRandomLangExceptCurrentLang() -> GNI18NLang {
  var randomLang = GNI18N.shared.currentLang

  let langList = [
    GNI18NLang(langName: "zh-Hans"),
    GNI18NLang(langName: "en"),
    GNI18NLang(langName: "ja"),
  ]
  while randomLang == GNI18N.shared.currentLang {
    let randomInt = Int.random(in: 0..<3)
    randomLang = langList[randomInt]
  }

  return randomLang
}
