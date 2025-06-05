//
//  ViewController.swift
//  WalletriX
//
//  Created by Subham Patel on 28/05/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    let images = ["hand", "Flyable", "plan"]
    var timer: Timer?
    var currentIndex = 0
    
    let msgLabel1 = UILabel()
    let msgLabel2 = UILabel()
    let signUpButton = UIButton()
    let loginButton = UIButton()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
        startTimer()
        setupComponents()
        setupPageControl()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextItem() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        let indexPath = IndexPath(item: currentIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    @objc func navigateSignUp(){
        let signUpVC = SignupViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func navigateLogin(){
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    func setupComponents() {
        // Message Label 1
        msgLabel1.text = "Gain total control of your money"
        msgLabel1.textColor = .black
        msgLabel1.font = .systemFont(ofSize: 35, weight: .bold)
        msgLabel1.numberOfLines = 0
        msgLabel1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(msgLabel1)
        
        // Message Label 2
        msgLabel2.text = "Become your own money manager and make every cent count"
        msgLabel2.textColor = UIColor.black.withAlphaComponent(0.4)
        msgLabel2.font = .systemFont(ofSize: 15)
        msgLabel2.numberOfLines = 0
        msgLabel2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(msgLabel2)
        
        // Sign Up Button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .systemIndigo
        signUpButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        signUpButton.layer.cornerRadius = 10
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(navigateSignUp), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.systemIndigo.withAlphaComponent(0.3)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(navigateLogin), for: .touchUpInside)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            msgLabel1.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            msgLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            msgLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            msgLabel1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            msgLabel2.topAnchor.constraint(equalTo: msgLabel1.bottomAnchor, constant: 12),
            msgLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            msgLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            msgLabel2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: msgLabel2.bottomAnchor, constant: 30),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 350),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 350),
            loginButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - UICollectionView DataSource & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.configure(with: UIImage(named: images[indexPath.item]) ?? UIImage())
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .systemIndigo
        pageControl.pageIndicatorTintColor = UIColor.systemIndigo.withAlphaComponent(0.3)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / collectionView.frame.width)
        currentIndex = page
        pageControl.currentPage = currentIndex
    }

}

// MARK: - Custom Image Cell
class ImageCell: UICollectionViewCell {
    let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage) {
        imageView.image = image
    }
}
