//
//  HomeViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 31/05/25.
//

import Foundation
import UIKit
import FirebaseAuth
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
        
        NSLayoutConstraint.activate([
            tempLogoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            tempLogoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tempLogoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tempLogoutButton.heightAnchor.constraint(equalToConstant: 50),
            tempLogoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    @objc func logout(){
        do{
            try Auth.auth().signOut()
            
            let VC = ViewController()
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true)
            
        } catch let signOutError as NSError{
            print("Error signing out: %@", signOutError)
        }
    }
}
