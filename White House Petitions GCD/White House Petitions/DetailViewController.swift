//
//  DetailViewController.swift
//  White House Petitions
//
//  Created by Felipe on 7/4/19.
//  Copyright © 2019 Felipe. All rights reserved.
//

import UIKit
import WebKit
class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let detailItem = detailItem else{ return }
        
        let html = """
            <html>
            <head>
            <meta name="viewport" content="width=device-width, initial-
            scale=1">
            <style> body { font-size: 150%; } </style>
            </head>
            <body>
            \(detailItem.body)
            </body>
            </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }
    


}
