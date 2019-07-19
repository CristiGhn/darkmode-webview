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
    var isDarkMode = false // default is false
    
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
    
    private var darkModeCSS : String {
        
        get {
            
            guard let darkmodeCSSFile = Bundle.main.path(forResource: "darkmode", ofType: "css") else {
                return ""
            }
            
            do {
                
                let css = try String(contentsOfFile: darkmodeCSSFile)
                return css
                
            } catch let error {
                print("Content fetching error:", error)
            }
            
            return ""
        }
    }
    
    private var injectCSS : String {
        
        get {
            
            let escapedCSS = String(format: "\"%@\"", self.darkModeCSS)
            
            let replace1 = escapedCSS.replacingOccurrences(of: "\n", with: "")
            print("replace1")
            print(replace1)
            
            let javaScript = "injectCSS(\(replace1))"
            return javaScript
            
        }
    }
    
    private var darkModeLibraryJS : String {
        
        get {
            
            guard let darkmodeScriptFile = Bundle.main.path(forResource: "darkmode", ofType: "js") else {
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
    
    private var injectDarkModeJS : String {
        
        get {
            
            guard let darkmodeScriptFile = Bundle.main.path(forResource: "inject-darkmode", ofType: "js") else {
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
        
        let webConfiguration = WKWebViewConfiguration()
        let contentController = WKUserContentController()
        
        // Libray script an document start
        let darkModeScript = WKUserScript(source: self.darkModeLibraryJS, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(darkModeScript)
        
        let injectDarkModeScript = WKUserScript(source: self.injectDarkModeJS, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(injectDarkModeScript)
        
        let injectCSScript = WKUserScript(source: self.injectCSS, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
        contentController.addUserScript(injectCSScript)
        
        webConfiguration.userContentController = contentController
        
        self.webview = WKWebView(frame: CGRect.zero, configuration: webConfiguration)
        self.webview?.navigationDelegate = self
        self.view.addSubview(webview!)
        
        self.webview!.loadHTMLString(html, baseURL: nil)
        self.webview!.fillSuperview() // after view has been added as subview
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.chechHTML()
    }
    
    private func chechHTML() {
        
        let script = "document.documentElement.outerHTML.toString()"
        
        self.webview?.evaluateJavaScript(script, completionHandler: { (html, error) in
            
            if html != nil {
                print("❌: check html response", html ?? "")
            }
            if error != nil {
                print("❌: check html with error", error ?? "")
            }
        })
    }
    
    @IBAction func toggleDarkMode(_ sender: Any) {
        var js = ""
        if self.isDarkMode {
            js = "showOriginalMode()"
        } else {
            js = "showDarkMode()"
        }
        
        self.isDarkMode = !self.isDarkMode
        
        self.webview?.evaluateJavaScript(js, completionHandler: { (html, error) in
            
            if html != nil {
                print("❌: check html response", html ?? "")
            }
            if error != nil {
                print("❌: check html with error", error ?? "")
            }
        })
    }
}
