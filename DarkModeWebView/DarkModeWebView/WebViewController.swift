//
//  ViewController.swift
//  DarkModeWebView
//
//  Created by Cristian Ghinea on 09/07/2019.
//  Copyright © 2019 Cristian Ghinea. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webview: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initWebView()
    }

    private var demoHTML : String {
        get {
            
            guard let demoHTMLFile = Bundle.main.path(forResource: "demo", ofType: "html") else {
                return ""
            }
            
            do {
                
                let html = try String(contentsOfFile: demoHTMLFile)
                return html
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }
    
    private var darkModeLibraryJS : String {
        
        get {
            
            guard let darkmodeScriptFile = Bundle.main.path(forResource: "darkmode.min", ofType: "js") else {
                return ""
            }
            
            do {
                
                let javascript = try String(contentsOfFile: darkmodeScriptFile)
                return javascript
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }
    
    private var darkModeOptionsJS : String {
        
        get {
            
            guard let darkmodeScriptFile = Bundle.main.path(forResource: "darkmode-options", ofType: "js") else {
                return ""
            }
            
            do {
                
                let javascript = try String(contentsOfFile: darkmodeScriptFile)
                return javascript
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }

    private func initWebView() {
        
            let html = self.demoHTML
            let jsLibrary = self.darkModeLibraryJS
            let jsOptions = self.darkModeOptionsJS
            
            let webConfiguration = WKWebViewConfiguration()
            let contentController = WKUserContentController()
        
            // Libray script an document start
            let userScript = WKUserScript(source: jsLibrary, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
            contentController.addUserScript(userScript)

            // Options script and document end
            let optionsScript = WKUserScript(source: jsOptions, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            contentController.addUserScript(optionsScript)
        
            webConfiguration.userContentController = contentController
            
            
            self.webview = WKWebView(frame: CGRect.zero, configuration: webConfiguration)
            self.webview?.navigationDelegate = self
            self.view.addSubview(webview!)
            
            self.webview!.loadHTMLString(html, baseURL: nil)
            self.webview!.fillSuperview() // after view has been added as subview
    }
}

