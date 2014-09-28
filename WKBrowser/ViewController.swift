//
//  ViewController.swift
//  WKBrowser
//
//  Created by Keanu Lee on 9/27/14.
//  Copyright (c) 2014 Keanu Lee. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var url: String = String()
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView()
        self.webView!.scrollView.bounces = false
        
        //If you want to implement the delegate
        //self.webView!.navigationDelegate = self
        
        self.view = self.webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let req = NSURLRequest(URL: NSURL(string: url))
        self.webView!.loadRequest(req)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
