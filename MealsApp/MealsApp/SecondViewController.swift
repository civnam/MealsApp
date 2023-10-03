//
//  SecondViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupAnimations(fromWillAppear: true)
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimations(fromWillAppear: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAnimations(fromWillAppear: false)
    }
    
    
    private func setupAnimations(fromWillAppear: Bool) {
        self.navigationController?.navigationBar.isHidden = fromWillAppear ? true : false
        self.navigationController?.tabBarController?.tabBar.isHidden = fromWillAppear ? false : true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
