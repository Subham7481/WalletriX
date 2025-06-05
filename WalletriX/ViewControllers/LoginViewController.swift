//
//  LoginViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 29/05/25.
//

import Foundation
import UIKit
import FirebaseAuth
class LoginViewController: UIViewController, UITextViewDelegate{
    let emailField = UITextField()
    let passwordField = UITextField()
    let toggleButton = UIButton(type: .system)
    let loginButton = UIButton()
    let forgotPassword = UITextView()
    let signUpMessage = UITextView()
    let errorMessage = UILabel()
    
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
        emailField.backgroundColor = .white
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)
        
        //Psssword Field
        passwordField.placeholder = "Password"
        passwordField.textColor = .black
        passwordField.backgroundColor = .white
        passwordField.borderStyle = .roundedRect
        passwordField.autocapitalizationType = .none
        passwordField.autocorrectionType = .no
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.isSecureTextEntry = true
        view.addSubview(passwordField)
        
        toggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        toggleButton.tintColor = .gray
        toggleButton.addTarget(self, action: #selector(togglePasswordVisible), for: .touchUpInside)
        
        passwordField.rightView = toggleButton
        passwordField.rightViewMode = .always
        
        //Login Button
        loginButton.setTitle("Login", for: .normal)
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
        
        //Error Messasge
        errorMessage.textColor = .systemRed
        errorMessage.font = .systemFont(ofSize: 16)
        errorMessage.textAlignment = .center
        errorMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorMessage)

        
        NSLayoutConstraint.activate([
            // Email Field
            emailField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            // Password Field
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            // Login Button
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Forgot Password
            forgotPassword.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            forgotPassword.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            forgotPassword.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            
            // Sign Up Message
            signUpMessage.topAnchor.constraint(equalTo: forgotPassword.bottomAnchor, constant: 20),
            signUpMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 300),
            
            // Error Message
            errorMessage.topAnchor.constraint(equalTo: signUpMessage.bottomAnchor, constant: 30),
            errorMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
    }
    
    @objc func togglePasswordVisible(){
        passwordField.isSecureTextEntry.toggle()
        
        let image = passwordField.isSecureTextEntry ? "eye" : "eye.slash"
        toggleButton.setImage(UIImage(systemName: image), for: .normal)
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

extension LoginViewController{
    @objc func login(){
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty else {
            errorMessage.text = "Please enter email and password"
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] result, error in
        if let error = error {
            self?.errorMessage.text = "Login failed: \(error.localizedDescription)"
            return
        }
            
        DispatchQueue.main.async {
            let homeVC = MainTabBarController()
            homeVC.modalPresentationStyle = .fullScreen
            self?.present(homeVC, animated: true)
        }
        }
    }
    
    func validate(){
        guard   let email = emailField.text,
            let password = passwordField.text,
            !email.isEmpty,
            !password.isEmpty else {
            errorMessage.text = "Please fill all fields and agree to terms."
            return
        }
        
        guard email.contains("@"), email.contains(".") else {
            errorMessage.text = "Please enter a valid email."
            return
        }
        
        guard password.count >= 6 else {
            errorMessage.text = "Password must be at least 6 characters."
            return
        }
        
        let uppercase = CharacterSet.uppercaseLetters
            let lowercase = CharacterSet.lowercaseLetters
            let digits = CharacterSet.decimalDigits
            let symbols = CharacterSet.punctuationCharacters.union(.symbols)

        guard password.rangeOfCharacter(from: uppercase) != nil,
            password.rangeOfCharacter(from: lowercase) != nil,
            password.rangeOfCharacter(from: digits) != nil,
            password.rangeOfCharacter(from: symbols) != nil else {
            errorMessage.text = "Password must include upper/lowercase, a number, and a symbol."
            return
        }
        login()
        errorMessage.text = ""
    }
}
