# SwiftWebViewSample
某書籍を元としたSwiftでのWebViewのサンプル。iOS8のWKWebView出し分け対応あり。

## 書籍との異なる点
- WKNavigationDelegateプロトコルのdelegateメソッドの引数をスコープを考慮してwkWebView: WKWebViewとした
- ~~containerへのaddSubviewの引数webViewもしくはwkWebViewをアンラップした~~
