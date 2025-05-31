//
//  TermsViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 30/05/25.
//

import Foundation
import UIKit
class TermsViewController: UIViewController{
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Terms and conditions."
        view.backgroundColor = .white
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        These are the Terms and Conditions...
        1. You agree to use the app responsibly.
        2. Your data will be used as per our policy.
        ...
        """
        label.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
