//
//  LoadingView.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation
import UIKit

class LoadingView {
    
    class func display(_ show: Bool, loadingText : String = "") {
        DispatchQueue.main.async {
            let existingView = UIApplication.shared.keyWindow?.viewWithTag(1200)
            if show {
                if existingView != nil {
                    return
                }
                let loadingView = self.makeLoadingView(withFrame: UIScreen.main.bounds, loadingText: loadingText)
                loadingView?.tag = 1200
                if let loadingView = loadingView {
                    UIApplication.shared.keyWindow?.addSubview(loadingView)
                }
            } else {
                existingView?.removeFromSuperview()
            }
        }
    }
    
    class func makeLoadingView(withFrame frame: CGRect, loadingText text: String?) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        activityIndicator.tag = 100
        
        loadingView.addSubview(activityIndicator)
        if !text!.isEmpty {
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            let cpoint = CGPoint(x: activityIndicator.frame.origin.x + activityIndicator.frame.size.width / 2, y: activityIndicator.frame.origin.y + 80)
            lbl.center = cpoint
            lbl.textColor = .white
            lbl.textAlignment = .center
            lbl.text = text
            lbl.tag = 1234
            loadingView.addSubview(lbl)
        }
        return loadingView
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}
