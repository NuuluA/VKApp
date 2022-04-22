//
//  AuthViewController.swift
//  VK
//
//  Created by Арген on 15.04.2022.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webViewVK: WKWebView = {
       let webview = WKWebView()
        webview.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authVK()
        webViewVK.navigationDelegate = self
        setConstraints()
        
        guard let token = UserDefaults.standard.string(forKey: "token") else { return }
        AccessToken.shared.token = token
    }
    
    private func authVK() {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8142557"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value:  "groups, photos, wall, friends, video, status, notes, pages, status, users"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "revoke", value: "1"),
            URLQueryItem(name: "v", value: "5.81")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        webViewVK.load(request)
    }
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {

        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }

        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        UserDefaults.standard.setValue(token, forKey: "token")
        let vc = MainTabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        decisionHandler(.cancel)
    }
}

extension AuthViewController {
    func setConstraints() {
        view.addSubview(webViewVK)
        NSLayoutConstraint.activate([
            webViewVK.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webViewVK.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            webViewVK.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            webViewVK.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
