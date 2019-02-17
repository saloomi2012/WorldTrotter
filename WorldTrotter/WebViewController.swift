//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Suliman Alsaid on 2/17/19.
//  Copyright © 2019 Suliman Alsaid. All rights reserved.
//

import UIKit
import WebKit

class WebViewController : UIViewController {
    var webView: WKWebView!
    
    override func loadView() {
        let webconfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webconfig)
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.bignerdranch.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}
