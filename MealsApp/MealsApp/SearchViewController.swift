//
//  SearchViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 03/10/23.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController {
    
    private let viewModel = MealsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentSearchView()
    }

    private func presentSearchView() {
        let searchView = ContentView(viewModel: self.viewModel)
        let searchVC = UIHostingController(rootView: searchView)
        searchVC.view.backgroundColor = .clear
        searchVC.modalPresentationStyle = .fullScreen
//        self.present(searchVC, animated: true)
        self.navigationController?.pushViewController(searchVC, animated: true)
    }
}
