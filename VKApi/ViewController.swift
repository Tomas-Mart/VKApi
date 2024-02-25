//
//  ViewController.swift
//  VKApi
//
//  Created by Amina TomasMart on 24.02.2024.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    private let manager = VKManager()
    
    lazy var webView: WKWebView = {
        $0.navigationDelegate = self
        return $0
    }(WKWebView(frame: view.frame))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        if let req = manager.getAuthRequest(){
            webView.load(req)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        //        access_token=vk1.a._1wwD_G1ibs1tYz43iKrgAI9d2XiwTTg-neWgeYQMyxwJm9goD66elX6abSqdEiEVE9_GTKXCQSfHtl6IQw5L2ETpum_1v6jbLFhBe1ShvuqgxCvw8icOH05k4CjvJRPvVf-SptsofSvJa-sy4PC9hbwU4ddcJ61JXIqcXa5QqttfPZR9bfBPzZYF55MRMVLu-HdArHHSpAnpPSjMOEC2Q&expires_in=0&user_id=137714871
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, param in
                var dict = res
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        print(fragment)
        if let token = params[.access_token] {
            UserDefaults.standard.setValue(token, forKey: .access_token)
            Session.shared.token = token
            NotificationCenter.default.post(name: .loginNotification, object: nil, userInfo: ["isLogin" : true])
        }
        decisionHandler(.cancel)
    }
}

extension String {
    static let access_token = "access_token"
}

extension Notification.Name {
    static let loginNotification = Notification.Name("loginNotification")
}

