//
//  MainTabBarController.swift
//  WalletriX
//
//  Created by Subham Patel on 04/06/25.
//
import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    let addButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.backgroundColor = .white
        tabBar.shadowImage = UIImage()                  // Remove top shadow line
        tabBar.backgroundImage = UIImage()              // Remove background image that might add shadow
        tabBar.layer.shadowOpacity = 0
        self.setValue(CurvedTabBar(), forKey: "tabBar")
        setupViewControllers()
        setupAddButton()
    }

    func setupViewControllers() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let transactions = UINavigationController(rootViewController: TransactionsViewController())
        let addVC = UINavigationController(rootViewController: AddExpencesViewController())
        let stats = UINavigationController(rootViewController: StatsViewController())
        let profile = UINavigationController(rootViewController: ProfileViewController())

        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        transactions.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "list.bullet.rectangle"), tag: 1)
        addVC.tabBarItem = UITabBarItem() // empty title/icon
        stats.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(systemName: "chart.pie.fill"), tag: 3)
        profile.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle.fill"), tag: 4)

        self.viewControllers = [home, transactions, addVC, stats, profile]
    }

    func setupAddButton() {
        addButton.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        addButton.backgroundColor = .systemIndigo
        addButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addButton.tintColor = .white
        addButton.layer.cornerRadius = 32
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.2
        addButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        addButton.layer.shadowRadius = 5

        let centerX = self.tabBar.center.x
        addButton.center = CGPoint(x: centerX, y: self.tabBar.frame.origin.y - 40)

        self.view.addSubview(addButton)

        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }

    @objc func addTapped() {
        self.selectedIndex = 2
    }
}


class CurvedTabBar: UITabBar {

    private var shapeLayer: CALayer?

    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.5

        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }

        self.shapeLayer = shapeLayer
    }

    override func draw(_ rect: CGRect) {
        self.addShape()
    }

    func createPath() -> CGPath {
        let height: CGFloat = 65
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: centerWidth - 50, y: 0))

        // Top center curve (concave)
        path.addQuadCurve(to: CGPoint(x: centerWidth + 50, y: 0),
                          controlPoint: CGPoint(x: centerWidth, y: height))

        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()

        return path.cgPath
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = false

        var tabFrame = self.frame
        tabFrame.size.height = 80
        tabFrame.origin.y = self.frame.origin.y + (self.frame.height - 80)
        self.frame = tabFrame
    }
}
