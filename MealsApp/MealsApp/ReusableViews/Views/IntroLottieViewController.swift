//
//  IntroLottieViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import UIKit
import Lottie

class IntroLottieViewController: UIViewController {
    
    let completion: Callback
    var coordinatorDelegate: CoordinatorDelegate?
    
    init(completion: @escaping Callback) {
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var lottieView: LottieAnimationView = {
        let view: LottieAnimationView
        view = .init(name: "intro_MealsApp")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.animationSpeed = 2.6
        view.backgroundColor = .customYellow2
        return view
    }()
    
    private var lottieActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
        activityIndicator.color = .white
        activityIndicator.style = .large
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLottieView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLottieAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setCustomView()
    }

    private func setLottieView() {
        
        view.addSubview(lottieView)
        view.addSubview(lottieActivityIndicator)
        
        lottieActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lottieActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        lottieView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        lottieView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        lottieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        lottieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupLottieAnimation() {
        
        lottieView.contentMode = .scaleAspectFit
        lottieView.play(completion: { completed in
            self.completion(completed)
        })
    }
    
    private func setCustomView() {
        view.backgroundColor = .customBlue1
        lottieActivityIndicator.isHidden = false
        lottieView.isHidden = true
    }
}
