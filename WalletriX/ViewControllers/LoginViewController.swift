//
//  LoginViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 29/05/25.
//

import Foundation
import UIKit
class LoginViewController: UIViewController, UITextViewDelegate{
    let emailField = UITextField()
    let passwordField = UITextField()
    let toggleButton = UIButton(type: .system)
    let loginButton = UIButton()
    let forgotPassword = UITextView()
    let signUpMessage = UITextView()
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .white
        
        components()
        
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
        passwordField.placeholder = "Password"
        passwordField.textColor = .black
        passwordField.borderStyle = .roundedRect
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordField)
        
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(togglePasswordVisible), for: .touchUpInside)
        
        passwordField.rightView = toggleButton
        passwordField.rightViewMode = .always
        
        //Login Button
        loginButton.setTitle("Sign Up", for: .normal)
        loginButton.backgroundColor = UIColor.systemIndigo
        loginButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
        
        //Forgot Password
        let forgotPassword = UILabel()
        forgotPassword.text = "Forgot Password?"
        forgotPassword.textColor = UIColor.systemIndigo
        forgotPassword.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        forgotPassword.textAlignment = .center
        forgotPassword.isUserInteractionEnabled = true
        forgotPassword.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(forgotPassword)

        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTapped))
        forgotPassword.addGestureRecognizer(tapGesture)

        
        //Sign up message
        let signUpText = "Don't have an account yet? Sign Up"
        let attributedSignUpText = NSMutableAttributedString(string: signUpText)
        let font = UIFont.systemFont(ofSize: 16)

        // Fix the range by searching for "Sign Up" with space
        let signUpRange = (signUpText as NSString).range(of: "Sign Up")

        // Add tappable link
        attributedSignUpText.addAttribute(.link, value: "action://signup", range: signUpRange)

        // Colors
        attributedSignUpText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: signUpText.count))
        attributedSignUpText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: signUpRange)

        // Apply to UITextView
        signUpMessage.attributedText = attributedSignUpText
        signUpMessage.isEditable = false
        signUpMessage.isSelectable = true
        signUpMessage.isScrollEnabled = false
        signUpMessage.textAlignment = .center
        signUpMessage.backgroundColor = .clear
        signUpMessage.dataDetectorTypes = []
        signUpMessage.textContainerInset = .zero
        signUpMessage.textContainer.lineFragmentPadding = 0
        signUpMessage.delegate = self
        signUpMessage.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(signUpMessage)

        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 360),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            forgotPassword.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            forgotPassword.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            forgotPassword.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            signUpMessage.topAnchor.constraint(equalTo: forgotPassword.bottomAnchor, constant: 20),
            signUpMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpMessage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    @objc func togglePasswordVisible(){
        passwordField.isSecureTextEntry.toggle()
        
        let image = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        toggleButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc func login(){
        
    }
    
    @objc func forgotPasswordTapped(){
        let forgotPassVC = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPassVC, animated: true)
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool
    {
        if URL.absoluteString == "action://signup" {
            print("Login tapped")
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
            return false
        }
        return true
    }
}
