//
//  ForgotPasswordViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 31/05/25.
//

import Foundation
import UIKit
class ForgotPasswordViewController: UIViewController{
    let emailField = UITextField()
    let newPasswordField = UITextField()
    let confirmPasswordField = UITextField()
    let continueButton = UIButton(type: .system)
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Reset Password"
        view.backgroundColor = .white
        
        
        
    }
    func components(){
        //Email Field
        emailField.placeholder = "Email"
        emailField.textColor = .black
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)
        
        //Psssword Field
        newPasswordField.placeholder = "Password"
        newPasswordField.textColor = .black
        newPasswordField.borderStyle = .roundedRect
        newPasswordField.autocapitalizationType = .none
        newPasswordField.autocorrectionType = .no
        newPasswordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newPasswordField)
        
        //Confirm Password Field
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.textColor = .black
        confirmPasswordField.borderStyle = .roundedRect
        confirmPasswordField.autocapitalizationType = .none
        confirmPasswordField.autocorrectionType = .no
        confirmPasswordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(confirmPasswordField)
        
        //Continue Button
        continueButton.setTitle("Sign Up", for: .normal)
        continueButton.backgroundColor = UIColor.systemIndigo
        continueButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        continueButton.layer.cornerRadius = 10
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            newPasswordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            newPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            newPasswordField.heightAnchor.constraint(equalToConstant: 50),
            
            confirmPasswordField.topAnchor.constraint(equalTo: newPasswordField.bottomAnchor, constant: 20),
            confirmPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 50),
            
            continueButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 20),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.widthAnchor.constraint(equalToConstant: 360),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
    @objc func resetPassword(){
        
    }
}
