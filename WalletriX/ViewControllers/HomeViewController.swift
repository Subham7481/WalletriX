//
//  HomeViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 31/05/25.
//

import Foundation
import UIKit
class HomeViewController: UIViewController{
    let tempLogoutButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home View"
        view.backgroundColor = .white
        
        tempLogoutButton.setTitle("Logout", for: .normal)
        tempLogoutButton.backgroundColor = UIColor.systemRed
        tempLogoutButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        tempLogoutButton.frame = CGRect(x: 30, y: 300, width: 330, height: 50)
        tempLogoutButton.layer.cornerRadius = 10
        tempLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        tempLogoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(tempLogoutButton)
    }
    @objc func logout(){
        
    }
}
