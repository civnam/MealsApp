//
//  MealsCategoryTableViewController.swift
//  MainApp
//
//  Created by Isaac Dimas on 02/10/23.
//

import UIKit

class MealsCategoryTableViewController: UIViewController {

    private var presenter = MealsPresenter(mealsApiService: MealsAPI())
    var mealCategory: MealsCategory?
    let heightCell: Int = 90
    
    private var mealsOfCategoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MealCell.self, forCellReuseIdentifier: MealCell.identifier)
        tableView.backgroundView = nil
        tableView.backgroundView = UIView()
        tableView.backgroundView!.backgroundColor = .customYellow2
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
        setupPresenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupTabBar(fromWillAppear: true)
        setupNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setupTabBar(fromWillAppear: false)
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.backgroundColor = .customYellow2
    }
    
    private func setupTabBar(fromWillAppear: Bool) {
        navigationController?.tabBarController?.tabBar.isHidden = fromWillAppear ? true : false
    }
    
    private func setupTableView() {
        
        view.addSubview(mealsOfCategoryTableView)
        mealsOfCategoryTableView.register(MealCell.self, forCellReuseIdentifier: MealCell.identifier)
        mealsOfCategoryTableView.delegate = self
        mealsOfCategoryTableView.dataSource = self
        mealsOfCategoryTableView.backgroundColor = .customYellow2
        mealsOfCategoryTableView.separatorStyle = .none
    }
    
    private func setupConstraints() {
        
        mealsOfCategoryTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mealsOfCategoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        mealsOfCategoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mealsOfCategoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    private func setupPresenter() {
        presenter.setMealsDelegate(mealsViewDelegate: self)
        presenter.getAllMeals(category: mealCategory ?? .beef)
    }
}

extension MealsCategoryTableViewController: MealsViewDelegate {
    
    func refreshMealsData() {
        DispatchQueue.main.async {
            self.mealsOfCategoryTableView.reloadData()
        }
    }
}

extension MealsCategoryTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getTotalMeals()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MealCell.identifier, for: indexPath) as? MealCell else { return UITableViewCell() }
        let meal = self.presenter.getMeal(indexPath: indexPath.row)
        cell.setMeal(meal: meal)
        return cell
    }
}

extension MealsCategoryTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightCell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealDetailVC = MealDetailViewController()
        let meal = self.presenter.getMeal(indexPath: indexPath.row)
        mealDetailVC.idMeal = meal.idMeal
        self.navigationController?.pushViewController(mealDetailVC, animated: true)
    }
}
