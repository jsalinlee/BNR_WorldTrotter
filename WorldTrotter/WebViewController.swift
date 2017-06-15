//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Jonathan Salin Lee on 6/12/17.
//  Copyright © 2017 Salin Studios. All rights reserved.
//

import UIKit;
import WebKit;

class WebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!;
    
    override func loadView() {
        webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration());
        webView.uiDelegate = self;
        view = webView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        webView.load(URLRequest(url: URL(string: "https://www.bignerdranch.com/")!));
    }
}
