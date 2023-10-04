//
//  MealsViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import UIKit

protocol MealsViewDelegate: NSObject {
    func refreshMealsData()
}

class MealsViewController: UIViewController {
    
    private var heightTableView: NSLayoutConstraint?
    private var heightCollectionView: NSLayoutConstraint?
    private var heightLogoImvVw: NSLayoutConstraint?
    private var heightMoreMealsLbl: NSLayoutConstraint?
    private var heightWeekSpecialLbl: NSLayoutConstraint?
    private var heightScrollView: NSLayoutConstraint?
    private let heightCell: Int = 90
    
    private var presenter = MealsPresenter(mealsApiService: MealsAPI())

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private var viewOfScrollView: UIView = {
        let view = UIView(frame: CGRect())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .customBlue1
        return view
    }()
    
    private var logoImageVw: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.image = UIImage(named: "ForkKnife")
        imageView.layer.applyWhiteShadow()
        imageView.layer.borderWidth = 0
        return imageView
    }()
    
    private var weekSpecialLbl: UILabel = {
        let label = UILabel()
        let text = "The week specialty \n Desserts! 🍽️"
        label.text = text
        label.font = UIFont(name: "Montserrat-SemiBold", size: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.applyWhiteShadow()
        return view
    }()
    
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MealCell.self, forCellReuseIdentifier: MealCell.identifier)
        tableView.backgroundView = nil
        tableView.backgroundView = UIView()
        tableView.backgroundView!.backgroundColor = .customYellow2
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    
    private var mainActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.color = .customBlue1
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private var moreMealslLbl: UILabel = {
        let label = UILabel()
        let text = "More delicious meals"
        label.text = text
        label.font = UIFont(name: "AnandaBlackPersonalUse-Regular", size: 36)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var moreView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.applyWhiteShadow()
        view.backgroundColor = .none
        return view
    }()
    
    private var moreCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .customYellow2
        collectionView.layer.cornerRadius = 10
        collectionView.register(CategoryMealCell.self, forCellWithReuseIdentifier: CategoryMealCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .customBlue1
        setupTableView()
        setupCollectionView()
        setupPresenter()
        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar(fromWillAppear: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar(fromWillAppear: false)
    }
    
    private func setupNavigationBar(fromWillAppear: Bool) {
        navigationController?.navigationBar.isHidden = fromWillAppear ? true : false
    }

    private func setupPresenter() {
        presenter.setMealsDelegate(mealsViewDelegate: self)
        presenter.getAllMeals()
        presenter.getAllCategories()
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(viewOfScrollView)
        viewOfScrollView.addSubview(logoImageVw)
        viewOfScrollView.addSubview(weekSpecialLbl)
        viewOfScrollView.addSubview(mainView)
        viewOfScrollView.addSubview(moreMealslLbl)
        viewOfScrollView.addSubview(moreView)
        mainView.addSubview(mainTableView)
        mainView.addSubview(mainActivityIndicator)
        moreView.addSubview(moreCollectionView)
    }
    
    private func setupConstraints() {

        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        viewOfScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        viewOfScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        viewOfScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        viewOfScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        viewOfScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        self.heightScrollView = viewOfScrollView.heightAnchor.constraint(equalToConstant: 900)
        self.heightScrollView?.isActive = true
        
        logoImageVw.topAnchor.constraint(equalTo: viewOfScrollView.topAnchor, constant: 25).isActive = true
        logoImageVw.centerXAnchor.constraint(equalTo: viewOfScrollView.centerXAnchor, constant: 0).isActive = true
        logoImageVw.widthAnchor.constraint(equalToConstant: 170).isActive = true
        
        self.heightLogoImvVw = logoImageVw.heightAnchor.constraint(equalToConstant: 150)
        self.heightLogoImvVw?.isActive = true
        
        weekSpecialLbl.topAnchor.constraint(equalTo: logoImageVw.bottomAnchor, constant: 10).isActive = true
        weekSpecialLbl.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        weekSpecialLbl.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true
        
        self.heightWeekSpecialLbl = weekSpecialLbl.heightAnchor.constraint(equalToConstant: 100)
        self.heightWeekSpecialLbl?.isActive = true
        
        mainView.topAnchor.constraint(equalTo: weekSpecialLbl.bottomAnchor, constant: 15).isActive = true
        mainView.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true

        self.heightTableView = mainView.heightAnchor.constraint(equalToConstant: 390)
        self.heightTableView?.isActive = true

        mainActivityIndicator.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        mainActivityIndicator.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 0).isActive = true
        
        mainTableView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
        
        moreMealslLbl.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 30).isActive = true
        moreMealslLbl.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        moreMealslLbl.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true
        
        self.heightMoreMealsLbl = moreMealslLbl.heightAnchor.constraint(equalToConstant: 50)
        self.heightMoreMealsLbl?.isActive = true
        
        moreView.topAnchor.constraint(equalTo: moreMealslLbl.bottomAnchor, constant: 15).isActive = true
        moreView.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        moreView.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true
        
        moreCollectionView.topAnchor.constraint(equalTo: moreView.topAnchor, constant: 0).isActive = true
        moreCollectionView.bottomAnchor.constraint(equalTo: moreView.bottomAnchor, constant: 0).isActive = true
        moreCollectionView.leadingAnchor.constraint(equalTo: moreView.leadingAnchor, constant: 0).isActive = true
        moreCollectionView.trailingAnchor.constraint(equalTo: moreView.trailingAnchor, constant: 0).isActive = true
        
        self.heightCollectionView = moreView.heightAnchor.constraint(equalToConstant: 150)
        self.heightCollectionView?.isActive = true
        
        setupResponsiveSizeScrollView()
    }
    
    private func setupResponsiveSizeScrollView() {
        
        var totalHeightScrollView: CGFloat = 0
        let screenSize = UIScreen.main.bounds
        let heightLogoImvVw = self.heightLogoImvVw?.constant ?? 0
        let heightTableView = self.heightTableView?.constant ?? 0
        let heightMoreMealsLbl = self.heightMoreMealsLbl?.constant ?? 0
        let heightWeekSpecialLbl = self.heightWeekSpecialLbl?.constant ?? 0
        let heightCollectionView = self.heightCollectionView?.constant ?? 0

        totalHeightScrollView = heightLogoImvVw + heightTableView + heightMoreMealsLbl + heightWeekSpecialLbl + heightCollectionView + CGFloat(140)

        if totalHeightScrollView < (screenSize.height) {
            totalHeightScrollView = screenSize.height - 100
        }

        self.heightScrollView?.constant = totalHeightScrollView
    }
    
    private func setupTableView() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
    }
    
    private func setupCollectionView() {
        
        moreCollectionView.delegate = self
        moreCollectionView.dataSource = self
    }
}

extension MealsViewController: UITableViewDataSource {
    
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

extension MealsViewController: UITableViewDelegate {
    
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

extension MealsViewController: MealsViewDelegate {
    
    func refreshMealsData() {
        
        DispatchQueue.main.async {
            self.refreshView()
        }
    }
    
    private func refreshView() {
        self.mainTableView.reloadData()
        self.mainActivityIndicator.stopAnimating()
    }
}


extension MealsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getTotalCategories()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryMealCell.identifier, for: indexPath) as? CategoryMealCell else { return UICollectionViewCell() }
        let mealCategory = self.presenter.getCategory(indexPath: indexPath.row)
        cell.setMeal(meal: mealCategory)
        return cell
    }
}

extension MealsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryTblCtlr = MealsCategoryTableViewController()
        let categoryMeal = self.presenter.getCategory(indexPath: indexPath.row)
        categoryTblCtlr.mealCategory = categoryMeal
        self.navigationController?.pushViewController(categoryTblCtlr, animated: true)
    }
}

extension MealsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
