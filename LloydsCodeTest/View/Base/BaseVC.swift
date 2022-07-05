//
//  BaseVC.swift
//  LloydsCodeTest
//
//  Created by Darshan Gajera on 04/07/2022.
//

import Foundation
import UIKit
import SafariServices

protocol URLOpenable {
    func open(url: String)
}

extension URLOpenable where Self: UIViewController {
    func open(url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

protocol CustomViewController {
    func setTitle(_ title: String)
}

extension CustomViewController where Self: UIViewController {
    func setTitle(_ title: String) {
        self.title = title
    }
}
