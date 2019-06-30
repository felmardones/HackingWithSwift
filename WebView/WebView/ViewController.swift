//
//  ViewController.swift
//  WebView
//
//  Created by Felipe on 6/14/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate {
    var webView = WKWebView()
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    var webUrl: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var url = URL(string: "https://" + websites[0])!
        if let webSiteUrl = webUrl {
            url = URL(string: "https://" + webSiteUrl)!
        }
        print(url)
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        let openWeb = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        let backWeb = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backPage))
        let forwardWeb = UIBarButtonItem(title: "Forward", style: .plain, target: self, action: #selector(forwardPage))
        
        navigationItem.rightBarButtonItems = [forwardWeb, backWeb, openWeb]
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        toolbarItems = [progressButton,spacer,refresh]
        navigationController?.isToolbarHidden = false
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }

    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page..", message: nil, preferredStyle: .actionSheet)
//        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
//        ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default, handler: openPage))
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default,
                                       handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    @objc func backPage(){
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @objc func forwardPage(){
        if webView.canGoForward{
            webView.goForward()
        }
    }
    
    func openPage(action:UIAlertAction){
        let url = URL(string: "https://"+action.title!)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    //limit where the user can navigate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let ac = UIAlertController(title: "You can't access to this page", message: "It' Blocked!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        let url = navigationAction.request.url
        if let host = url?.host{
            for website in websites{
                if host.contains(website){
                    print("Correct url \(host)")
                    decisionHandler(.allow)
                    return
                }
            }
        }else{
            print("Incorrect url \(String(describing: url!.host))")
            present(ac, animated: true)
        }
        decisionHandler(.cancel)

    }
}

