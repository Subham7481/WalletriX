//
//  ProfileViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 04/06/25.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController{
    let tempLogoutButton = UIButton(type: .system)
    let profileImage = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        loadProfileImage()
        profileImage.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        profileImage.addGestureRecognizer(tap)
        
        components()
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            
            tempLogoutButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 480),
            tempLogoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tempLogoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tempLogoutButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    func components(){
        tempLogoutButton.setTitle("Logout", for: .normal)
        tempLogoutButton.backgroundColor = UIColor.systemRed
        tempLogoutButton.setTitleColor(.white, for: .normal)
        tempLogoutButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        tempLogoutButton.frame = CGRect(x: 30, y: 300, width: 330, height: 50)
        tempLogoutButton.layer.cornerRadius = 10
        tempLogoutButton.translatesAutoresizingMaskIntoConstraints = false
        tempLogoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        view.addSubview(tempLogoutButton)
        
        profileImage.image = UIImage(systemName: "person.circle.fill")
        profileImage.image?.withTintColor(.systemIndigo)
        profileImage.contentMode = .scaleAspectFill
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 60
        profileImage.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        profileImage.addGestureRecognizer(tapGesture)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileImage)
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

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func handleProfileImageTap(){
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        sheet.addAction(UIAlertAction(title: "Add Photo", style: .default, handler: { _ in
            self.pickImage()
        }))
            
        sheet.addAction(UIAlertAction(title: "Remove Photo", style: .destructive, handler: { _ in
            self.removeProfileImage()
        }))
            
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(sheet, animated: true)
    }
    
    func pickImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        if let image = info[.originalImage] as? UIImage {
            profileImage.image = image
            saveProfileImage(image)
        }
    }
    
    func saveProfileImage(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.9) {
            let filename = getDocumentsDirectory().appendingPathComponent("profile.jpg")
            try? data.write(to: filename)
            UserDefaults.standard.set("profile.jpg", forKey: "profileImageName")
        }
    }

    func loadProfileImage() {
        if let imageName = UserDefaults.standard.string(forKey: "profileImageName") {
            let fileURL = getDocumentsDirectory().appendingPathComponent(imageName)
            if let data = try? Data(contentsOf: fileURL), let image = UIImage(data: data) {
                profileImage.image = image
            } else {
                profileImage.image = UIImage(systemName: "person.circle.fill")
            }
        } else {
            profileImage.image = UIImage(systemName: "person.circle.fill")
        }
    }

    func removeProfileImage() {
        let fileURL = getDocumentsDirectory().appendingPathComponent("profile.jpg")
        try? FileManager.default.removeItem(at: fileURL)
        UserDefaults.standard.removeObject(forKey: "profileImageName")
        profileImage.image = UIImage(systemName: "person.circle.fill")
    }

    func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
