//
//  ViewController.swift
//  AttedanceManagement
//
//  Created by JENIL BHADJA on 28/07/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let webView : WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        let webView =   WKWebView(frame: .zero, configuration: configuration)
        
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let url  = URL(string: "https://attendancemangee.azurewebsites.net/Identity/Account/Login?ReturnUrl=%2F")else{
            return
        }
        webView.load(URLRequest(url: url))
        webView.customUserAgent = "ipad/Chrome/SomtingRandom"
        DispatchQueue.main.asyncAfter(deadline: .now()+5){
            self.webView.evaluateJavaScript("document.body.innnerHTMl") { result, error in
                guard let html = result as? String, error == nil else{
                    return
                }
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

}

