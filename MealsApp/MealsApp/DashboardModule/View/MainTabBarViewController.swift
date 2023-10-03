//
//  MainTabBarViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import UIKit

class MainTabBarViewController : UITabBarController {
    
    // MARK: - Atributes
    private var dashboardViewController: UIViewController
    private var secondViewController: UIViewController
    private var thirdViewController: UIViewController
    
    //MARK: - Init of class
    init(dashboardViewController: UIViewController, secondViewController: UIViewController, thirdViewController: UIViewController) {
        self.dashboardViewController = dashboardViewController
        self.secondViewController = secondViewController
        self.thirdViewController = thirdViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let btnMiddle : UIButton = {
       let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.backgroundColor = UIColor.customOrange2
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(named: "ForkKnife"), for: .normal)
        return btn
    }()
    
    override func loadView() {
        super.loadView()
        
        setupTabBar()
        setupCustomTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
    }
    
    private func setupTabBar() {
        
        delegate = self
        self.tabBar.addSubview(btnMiddle)
    }

    func setupCustomTabBar() {
        
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor.customOrange2
    }
    
    func setupViewControllers() {

//        setViewControllers([secondViewController, dashboardViewController, thirdViewController], animated: false)
        self.viewControllers = [secondViewController, dashboardViewController, thirdViewController]
        guard let items = tabBar.items else { return}
        items[0].title = "Search"
        items[2].title = "Calendar"
        items[0].image = UIImage(systemName: "magnifyingglass")
        items[2].image = UIImage(systemName: "calendar")
    }
    
    func getPathForTabBar() -> UIBezierPath {
        
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + 20
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }

        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }

        return true
    }
}
