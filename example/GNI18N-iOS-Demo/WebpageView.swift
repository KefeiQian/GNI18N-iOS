//
// Created by Kefei Qian on 2022/2/10.
//

import GNI18N
import SwiftUI
import WKWebViewJavascriptBridge
import WebKit

private class WebViewText: GNText {
  @Published var changeLanguageText: String!
  @Published var secondViewTitle: String!

  override init() {
    super.init()
    self.updateText()
  }

  override func updateText() {
    self.secondViewTitle = GNI18N.getLocalizedText(key: "second-view-title")
    self.changeLanguageText = GNI18N.getLocalizedText(key: "change-language-button")
  }
}

struct WebpageView: View {
  @ObservedObject fileprivate var text = WebViewText()

  var body: some View {
    WebViewController()
      .edgesIgnoringSafeArea(.all)
  }
}

struct WebViewController: UIViewControllerRepresentable {
  func updateUIViewController(_ uiViewController: _WebViewController, context: Context) {}

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> _WebViewController {
    return _WebViewController()
  }

  class Coordinator: NSObject {
    var parent: WebViewController

    init(_ vc: WebViewController) {
      parent = vc
    }
  }
}

class _WebViewController: UIViewController {
  let webView = WKWebView(frame: CGRect(), configuration: WKWebViewConfiguration())
  var bridge: WKWebViewJavascriptBridge!

  override func viewDidLoad() {
    super.viewDidLoad()

    webView.frame = view.bounds

    //    webView.load(URLRequest(url: URL(string: "http://localhost:8080")!))
    webView.load(
      URLRequest(
        url: URL(
          fileURLWithPath: Bundle.main.path(
            forResource: "index", ofType: "html", inDirectory: "dist")!)))

    view.addSubview(webView)

    bridge = GNI18N.shared.bindWebview(webView)
  }
}
