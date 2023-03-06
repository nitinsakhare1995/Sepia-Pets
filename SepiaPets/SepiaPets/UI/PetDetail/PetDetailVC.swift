//
//  PetDetailVC.swift
//  SepiaPets
//
//  Created by Nitin Sakhare on 06/03/23.
//

import UIKit
import WebKit

class PetDetailVC: UIViewController {
    
    // Outlets for the web view and activity indicator
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Instance variable for the content URL
    var contentUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the title of the view controller
        self.title = "Pet Detail"
        
        // Set the web view's navigation delegate
        webView.navigationDelegate = self
        
        // Create a URL request with the content URL
        if let url = URL(string: self.contentUrl ?? "") {
            let request = URLRequest(url: url)
            
            // Load the URL request in the web view
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }
    
}

// Implementation of the WKNavigationDelegate to handle web view events
extension PetDetailVC: WKNavigationDelegate {
    
    // Start animating the activity indicator when the page starts loading
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    // Stop animating the activity indicator when the page finishes loading
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    // Stop animating the activity indicator if the page fails to load
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
