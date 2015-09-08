//
//  ViewController.swift
//  WebViewApp
//
//  Created by タカハシケンイチ on 2015/09/08.
//  Copyright (c) 2015年 Kenichi Takahashi. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate {
    
    @IBOutlet var container: UIView!
    @IBOutlet var backButton: UIBarButtonItem!
    @IBOutlet var forwardButton: UIBarButtonItem!
    @IBOutlet var homeButton: UIBarButtonItem!
    @IBOutlet var reloadButton: UIBarButtonItem!

    var webView: UIWebView!
    var wkWebView: WKWebView!
    let url = NSURL(string: "http://map.yahoo.co.jp/mobile")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if osMajorVersion() >= 8 {
            // iOS 8 以上で荒ればWkWebViewを生成する
            wkWebView = WKWebView()
            
            // Auto Layoutが正しく働くようにするため、Auto Resizeを
            // 自動的に制約に変換しないようにする
            wkWebView.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // 生成したUIW絵bViewインスタンスをcontainerにサブビューとして追加する
            container.addSubview(wkWebView)
            setSameBoundsConstraints(container, child: wkWebView)
            
            // デリゲートとしてself(このViewController）を設定する
            wkWebView.navigationDelegate = self
        } else {
            // ウェブ表示用画面部品を生成する
            webView = UIWebView()
            
            // Auto Layoutが正しく働くようにするため、Auto Resizeを
            // 自動的に制約に変換しないようにする
            webView.setTranslatesAutoresizingMaskIntoConstraints(false)
            
            // 生成したUIW絵bViewインスタンスをcontainerにサブビューとして追加する
            container.addSubview(webView)
            setSameBoundsConstraints(container, child: webView)
            
            // デリゲートとしてself(このViewController）を設定する
            webView.delegate = self
        }
        
        // 戻る・進むボタンを無効化しておく
        backButton.enabled = false
        forwardButton.enabled = false
        
        //　指定のページを表示する
        goToHome()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSameBoundsConstraints(parent: UIView, child: UIView) {
        parent.addConstraints([
            NSLayoutConstraint(
                item: child,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: parent,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: child,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: parent,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: child,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: parent,
                attribute: NSLayoutAttribute.Width,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: child,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: parent,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1.0,
                constant: 0)
            ])
    }
    
    // 戻るボタンが押された場合に呼ばれる
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        if osMajorVersion() >= 8 {
            wkWebView.goBack()
        } else {
            webView.goBack()
        }
    }
    
    // 進むボタンが押された場合に呼ばれる
    @IBAction func forwardButtonPressed(sender: UIBarButtonItem) {
        if osMajorVersion() >= 8 {
            wkWebView.goForward()
        } else {
            webView.goForward()
        }
    }
    
    // ホームボタンが押された場合に呼ばれる
    @IBAction func homeButtonPressed(sender: UIBarButtonItem) {
        goToHome()
    }
    
    // リロードボタンが押された場合に呼ばれる
    @IBAction func reloadButtonPressed(sender: UIBarButtonItem) {
        if osMajorVersion() >= 8 {
            wkWebView.reload()
        } else {
            webView.reload()
        }
    }
    
    func goToHome() {
        // 定数urlから、NSURLRequestクラスのインスタンスを生成
        let request = NSURLRequest(URL: url!)
        
        // ウェブサイトの表示を要求する
        if osMajorVersion() >= 8 {
            wkWebView.loadRequest(request)
        } else {
            webView.loadRequest(request)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        backButton.enabled = webView.canGoBack
        forwardButton.enabled = webView.canGoForward
    }
    
    func webView(wkWebView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        backButton.enabled = wkWebView.canGoBack
        forwardButton.enabled = wkWebView.canGoForward
    }
    
    func osMajorVersion() -> Int? {
        // OSバージョン名を取得する
        let osVersionStr = UIDevice.currentDevice().systemVersion
        
        // バージョン名を.で分解した配列を作る
        let osVersionUnits = split(osVersionStr, isSeparator: {$0 == "."})
        
        // 配列の先頭がOSメジャーバージョyんなので、、それをIntにして返す
        return osVersionUnits[0].toInt()
    }
}

