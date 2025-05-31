//
//  SignupViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 29/05/25.
//

import Foundation
import UIKit
class SignupViewController: UIViewController, UITextViewDelegate{
    let nameField = UITextField()
    let emailField = UITextField()
    let passwordField = UITextField()
    let toggleButton = UIButton(type: .system)
    let checkBox = UIButton(type: .system)
    let checkBoxTextView = UITextView()
    let button = UIButton()
    let withMessage = UILabel()
    let googleSignUp = UIButton()
    let loginMessage = UITextView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        title = "Sign Up"
        view.backgroundColor = .white
        
        components()
        
    }
    func components(){
        //Name text field.
        nameField.placeholder = "Name"
        nameField.textColor = .black
        nameField.borderStyle = .roundedRect
        nameField.autocapitalizationType = .none
        nameField.autocorrectionType = .no
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)
        
        
        //Email text field.
        emailField.placeholder = "Email"
        emailField.textColor = .black
        emailField.borderStyle = .roundedRect
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailField)
        
        //Password text field.
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
        
        //Checkbox field.
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.setImage(UIImage(systemName: "square"), for: .normal)
        checkBox.tintColor = .gray
        checkBox.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
        view.addSubview(checkBox)
        
        //Checkbox label
        checkBoxTextView.translatesAutoresizingMaskIntoConstraints = false
        checkBoxTextView.isEditable = false
        checkBoxTextView.isScrollEnabled = false
        checkBoxTextView.backgroundColor = .clear
        checkBoxTextView.textAlignment = .left
        checkBoxTextView.font = UIFont.systemFont(ofSize: 20)
        checkBoxTextView.textContainerInset = .zero
        checkBoxTextView.textContainer.lineFragmentPadding = 0
        
        //Attribute text with tappable link.
        let fullText = "By signing up, you agree to the Terms of Service and Privacy Policy"
        let attributedString = NSMutableAttributedString(string: fullText)
        let linkRange = (fullText as NSString).range(of: "Terms of Service and Privacy Policy")
        attributedString.addAttribute(.link, value: "action://terms", range: linkRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: fullText.count))
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: linkRange)

        checkBoxTextView.attributedText = attributedString
        checkBoxTextView.delegate = self

        view.addSubview(checkBoxTextView)
        
        //Signup Button
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = UIColor.systemIndigo
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        view.addSubview(button)
        
        //With Message
        withMessage.text = "Or with"
        withMessage.textColor = .black
        withMessage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(withMessage)
        
        //Google signup Button
        googleSignUp.setTitle("Sign Up with Google", for: .normal)
        googleSignUp.setImage(UIImage(named: "Google"), for: .normal)
        googleSignUp.tintColor = .black
        googleSignUp.setTitleColor(.black, for: .normal)
        googleSignUp.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        googleSignUp.imageView?.contentMode = .scaleAspectFit
        googleSignUp.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        googleSignUp.layer.cornerRadius = 10
        googleSignUp.semanticContentAttribute = .forceLeftToRight

        // Clean and visible insets
        googleSignUp.contentEdgeInsets = UIEdgeInsets(top: 10, left: -200, bottom: 10, right: 20)
        googleSignUp.titleEdgeInsets = UIEdgeInsets(top: 0, left: -320, bottom: 0, right: -10)
        googleSignUp.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 10)

        googleSignUp.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleSignUp)

        
        //Login Message
        let loginText = "Already have an account? Login"
        let attributedLoginText = NSMutableAttributedString(string: loginText)
        let font = UIFont.systemFont(ofSize: 16)

        // Find the range of the "Login" text
        let loginRange = (loginText as NSString).range(of: "Login")

        // Make "Login" a tappable link
        attributedLoginText.addAttribute(.link, value: "action://login", range: loginRange)

        // Set default and link colors
        attributedLoginText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: loginText.count))
        attributedLoginText.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: loginRange)

        // Set the attributed text to the UITextView
        loginMessage.attributedText = attributedLoginText
        loginMessage.delegate = self
        loginMessage.backgroundColor = .clear
        loginMessage.textAlignment = .center
        loginMessage.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(loginMessage)




        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 50),
            
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            emailField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            checkBox.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            checkBox.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            checkBox.widthAnchor.constraint(equalToConstant: 24),
            checkBox.heightAnchor.constraint(equalToConstant: 24),
            
            checkBoxTextView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            checkBoxTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            checkBoxTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: checkBoxTextView.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 360),
            button.heightAnchor.constraint(equalToConstant: 50),
            
            withMessage.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            withMessage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 170),
            withMessage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            googleSignUp.topAnchor.constraint(equalTo: withMessage.bottomAnchor, constant: 20),
            googleSignUp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            googleSignUp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            googleSignUp.heightAnchor.constraint(equalToConstant: 50),


            loginMessage.topAnchor.constraint(equalTo: googleSignUp.bottomAnchor, constant: 20),
            loginMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginMessage.widthAnchor.constraint(equalToConstant: 300),
            loginMessage.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    @objc func togglePasswordVisible(){
        passwordField.isSecureTextEntry.toggle()
        
        let image = passwordField.isSecureTextEntry ? "eye.slash" : "eye"
        toggleButton.setImage(UIImage(systemName: image), for: .normal)
    }
    
    @objc func toggleCheck(){
        let isChecked = checkBox.currentImage == UIImage(systemName: "checkmark.square")
        let newImageName = isChecked ? "Square" : "checkmark.square"
        checkBox.setImage(UIImage(systemName: newImageName), for: .normal)
    }
    
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool{
//        if URL.absoluteString == "action://terms" {
//                // Navigate to TermsViewController
//        let termsVC = TermsViewController()
//        self.navigationController?.pushViewController(termsVC, animated: true)
//        return false
//        }
//        return true
//    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.absoluteString == "action://terms" {
            print("Terms tapped")
            let termsVC = TermsViewController()
            self.navigationController?.pushViewController(termsVC, animated: true)
            return false
        }
        
        if URL.absoluteString == "action://login" {
            print("Login tapped")
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
            return false
        }

        return true
    }

    
    
    @objc func signUp(){
        
    }
    
    @objc func signUpWithGoogle(){
        
    }
}
