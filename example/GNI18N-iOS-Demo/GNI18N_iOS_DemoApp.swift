//
//  GNI18N_iOS_DemoApp.swift
//  GNI18N-iOS-Demo
//
//  Created by Kefei Qian on 2022/2/10.
//

import GNI18N
import SwiftUI

@main
struct GNI18N_iOS_DemoApp: App {
  init() {
    GNI18N.setup()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
