//
//  MealDetailViewController.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import UIKit
import WebKit
import youtube_ios_player_helper

class MealDetailViewController: UIViewController {

    var heightTableView: NSLayoutConstraint?
    var heightVideoView: NSLayoutConstraint?
    var heightScrollView: NSLayoutConstraint?
    var heightInstructionsTxtVw: NSLayoutConstraint?
    var heightMealImage: NSLayoutConstraint?
    var heightMealIngredientsLbl: NSLayoutConstraint?
    let heightCell: Int = 70
    
    var idMeal: String?
    var completion: Completion?
    private var presenter = MealsPresenter(mealsApiService: MealsAPI())
    private var youtubeUrl = "https://www.youtube.com/watch?v="
    
    var calendarEntryPoint: Bool = false

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
    
    private var detailActivityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.color = .white
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    private var addMealButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus.circle.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.backgroundColor = .none
        button.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.widthAnchor.constraint(equalToConstant: 25).isActive = true
        button.addTarget(self, action: #selector(selectMeal), for: .touchUpInside)
        return button
    }()
    
    private var mealImage: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.applyWhiteShadow()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var mealTitleLbl: UILabel = {
        let label = UILabel()
        let text = ""
        label.font = UIFont(name: "Montserrat-Black", size: 24)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.isHidden = true
        label.backgroundColor = .customYellow2
        label.textAlignment = .center
        label.layer.applyWhiteShadow()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var mealIngredientsLbl: UILabel = {
        let label = UILabel()
        let text = "Ingredients & Measures"
        label.text = text
        label.font = UIFont(name: "MontserratAlternates-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.isHidden = true
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var mealInstructionsLbl: UILabel = {
        let label = UILabel()
        let text = "Instructions"
        label.text = text
        label.font = UIFont(name: "MontserratAlternates-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.isHidden = true
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private var mealInstructionsTxtVw: UITextView = {
       let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = ""
        textView.font = UIFont(name: "Raleway-Medium", size: 18)
        textView.textColor = .white
        textView.textAlignment = .justified
        textView.backgroundColor = .none
        textView.isScrollEnabled = false
        return textView
    }()
    
    private var mealTutorialVideoLbl: UILabel = {
        let label = UILabel()
        label.text = "Tutorial for the meal"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.layer.applyWhiteShadow()
        return view
    }()
    
    private var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(IngredientsCell.self, forCellReuseIdentifier: IngredientsCell.identifier)
        tableView.backgroundView = nil
        tableView.backgroundView = UIView()
        tableView.backgroundView!.backgroundColor = .customYellow2
        tableView.layer.cornerRadius = 15
        return tableView
    }()
    
    private var videoView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .customYellow2
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.applyWhiteShadow()
        view.backgroundColor = .none
        return view
    }()
    
    private var playerView: YTPlayerView = {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: "")
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.layer.applyWhiteShadow()
        playerView.layer.masksToBounds = true
        return playerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPresenter()
        setupMealInfo()
        setupTableView()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupViewConfig()
        setupTabBar(fromWillAppear: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setupTabBar(fromWillAppear: false)
    }
    
    @objc func selectMeal() {
        self.completion?(mealTitleLbl.text ?? "Undefined", idMeal ?? "")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupViewConfig() {
        
        if !calendarEntryPoint {
            customView()
        }
    }
    
    private func customView() {
        navigationController?.navigationBar.backgroundColor = .customBlue1
        view.backgroundColor = .customBlue1
    }
    
    private func setupTabBar(fromWillAppear: Bool) {
        
        self.navigationController?.tabBarController?.tabBar.isHidden = fromWillAppear ? true : false
    }
    
    private func showViews() {
        
        detailActivityIndicator.stopAnimating()
        mealImage.isHidden = false
        mealTitleLbl.isHidden = false
        mealIngredientsLbl.isHidden = false
        mainView.isHidden = false
        mealInstructionsLbl.isHidden = false
        videoView.isHidden = false
        view.isUserInteractionEnabled = true
    }

    private func setupPresenter() {
        presenter.setMealsDelegate(mealsViewDelegate: self)
        presenter.setMealDetail(idMeal: idMeal ?? "")
    }
    
    private func setupViews() {
        
        view.addSubview(scrollView)
        view.addSubview(detailActivityIndicator)
        scrollView.addSubview(viewOfScrollView)
        viewOfScrollView.addSubview(addMealButton)
        viewOfScrollView.addSubview(mealImage)
        viewOfScrollView.addSubview(mealTitleLbl)
        viewOfScrollView.addSubview(mealIngredientsLbl)
        viewOfScrollView.addSubview(mainView)
        viewOfScrollView.addSubview(mealInstructionsLbl)
        viewOfScrollView.addSubview(mealInstructionsTxtVw)
        viewOfScrollView.addSubview(videoView)
        mainView.addSubview(mainTableView)
        videoView.addSubview(playerView)
    }
    
    private func setupMealInfo() {
        guard let meal = presenter.getMealDetail() else {
            return
        }
        mealTitleLbl.text = meal.strMeal ?? "Apples & Oranges"
        mealImage.loadImage(urlStr: meal.strMealThumb ?? "")
        updateInstructionsTxtVw(text: meal.strInstructions ?? "Instructions for meal" )
        updateTableView()
        updatePlayerVideo(strUrl: meal.strYoutube ?? "")
        setupResponsiveSizeScrollView()
    }
    
    private func updateTableView() {
        
        mainTableView.reloadData()
        let totalIngredients = presenter.getMealTotalIngredients()
        heightTableView?.constant = CGFloat(heightCell) * CGFloat(totalIngredients ?? 0)
    }
    
    private func updateInstructionsTxtVw(text: String) {
        mealInstructionsTxtVw.text = text
        mealInstructionsTxtVw.sizeToFit()
        let height = mealInstructionsTxtVw.contentSize.height
        heightInstructionsTxtVw?.constant = height
    }
    
    private func updatePlayerVideo(strUrl: String) {
        let videoId = strUrl.replacingOccurrences(of: youtubeUrl, with: "")
        playerView.load(withVideoId: videoId)
    }
    
    private func setupConstraints() {
        
        let viewSafeArea = view.layoutMarginsGuide
        
        scrollView.topAnchor.constraint(equalTo: viewSafeArea.topAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        viewOfScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        viewOfScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        viewOfScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        viewOfScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        viewOfScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true

        self.heightScrollView = viewOfScrollView.heightAnchor.constraint(equalToConstant: 1200)
        self.heightScrollView?.isActive = true
        
        detailActivityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        detailActivityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        setupTopConstraints()

        self.heightMealImage = mealImage.heightAnchor.constraint(equalToConstant: 90)
        self.heightMealImage?.isActive = true
        
        mealTitleLbl.heightAnchor.constraint(equalToConstant: 90).isActive = true
        mealTitleLbl.bottomAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 0).isActive = true
        mealTitleLbl.leadingAnchor.constraint(equalTo: mealImage.trailingAnchor, constant: 16).isActive = true
        mealTitleLbl.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true
        
        mealIngredientsLbl.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 16).isActive = true
        mealIngredientsLbl.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        mealIngredientsLbl.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: 16).isActive = true
        
        self.heightMealIngredientsLbl = mealIngredientsLbl.heightAnchor.constraint(equalToConstant: 30)
        self.heightMealIngredientsLbl?.isActive = true
        
        mainView.topAnchor.constraint(equalTo: mealIngredientsLbl.bottomAnchor, constant: 20).isActive = true
        mainView.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        mainView.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true

        self.heightTableView = mainView.heightAnchor.constraint(equalToConstant: 390)
        self.heightTableView?.isActive = true

        mainTableView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 0).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 0).isActive = true
        
        mealInstructionsLbl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        mealInstructionsLbl.widthAnchor.constraint(equalToConstant:  CGFloat(UIScreen.main.bounds.width / 2)).isActive = true
        mealInstructionsLbl.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 24).isActive = true
        mealInstructionsLbl.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        
        self.heightInstructionsTxtVw = mealInstructionsTxtVw.heightAnchor.constraint(equalToConstant: 200)
        self.heightInstructionsTxtVw?.isActive = true
        
        mealInstructionsTxtVw.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        mealInstructionsTxtVw.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true
        mealInstructionsTxtVw.topAnchor.constraint(equalTo: mealInstructionsLbl.bottomAnchor, constant: 8).isActive = true
        
        videoView.topAnchor.constraint(equalTo: mealInstructionsTxtVw.bottomAnchor, constant: 15).isActive = true
        videoView.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
        videoView.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true

        playerView.topAnchor.constraint(equalTo: videoView.topAnchor, constant: 0).isActive = true
        playerView.bottomAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 0).isActive = true
        playerView.leadingAnchor.constraint(equalTo: videoView.leadingAnchor, constant: 0).isActive = true
        playerView.trailingAnchor.constraint(equalTo: videoView.trailingAnchor, constant: 0).isActive = true

        self.heightVideoView = videoView.heightAnchor.constraint(equalToConstant: 250)
        self.heightVideoView?.isActive = true
    }
    
    private func setupTopConstraints() {

        if calendarEntryPoint {

            addMealButton.topAnchor.constraint(equalTo: viewOfScrollView.topAnchor, constant: 5).isActive = true
            addMealButton.trailingAnchor.constraint(equalTo: viewOfScrollView.trailingAnchor, constant: -16).isActive = true

            mealImage.topAnchor.constraint(equalTo: addMealButton.bottomAnchor, constant: 10).isActive = true
            mealImage.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
            mealImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
            
        } else {

            addMealButton.isHidden = true

            mealImage.topAnchor.constraint(equalTo: viewOfScrollView.topAnchor, constant: 10).isActive = true
            mealImage.leadingAnchor.constraint(equalTo: viewOfScrollView.leadingAnchor, constant: 16).isActive = true
            mealImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        }

        self.heightMealImage = mealImage.heightAnchor.constraint(equalToConstant: 90)
        self.heightMealImage?.isActive = true
    }
    
    private func setupResponsiveSizeScrollView() {
        
        var heightScrollView: CGFloat = 0
        let heightMealImage = self.heightMealImage?.constant ?? 0
        let heightTableView = self.heightTableView?.constant ?? 0
        let heightMealIngredientsLbl = self.heightMealIngredientsLbl?.constant ?? 0
        let heightInstructionsTxtVw = self.heightInstructionsTxtVw?.constant ?? 0
        let heightCollectionView = self.heightVideoView?.constant ?? 0

        let screenSize = UIScreen.main.bounds

        if heightScrollView < (screenSize.height + 200) {
            heightScrollView = screenSize.height
        }

        let totalHeight = heightMealImage + heightTableView + heightInstructionsTxtVw + heightCollectionView + heightMealIngredientsLbl
        self.heightScrollView?.constant = totalHeight + 200
    }
    
    private func setupTableView() {
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
    }
    
}

extension MealDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.getMealTotalIngredients() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsCell.identifier, for: indexPath) as? IngredientsCell else { return UITableViewCell() }
        let ingredient = presenter.getMealIngredient(indexPath: indexPath.row)
        let measure = presenter.getMealMeasure(indexPath: indexPath.row)
        cell.setIngredient(ingredient: ingredient ?? "NONE", measure: measure ?? "NONE")
        return cell
    }
}

extension MealDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(heightCell)
    }
}

extension MealDetailViewController: MealsViewDelegate {
    
    func refreshMealsData() {
        
        DispatchQueue.main.async {
            self.refreshData()
        }
    }
    
    private func refreshData() {
        setupMealInfo()
        showViews()
    }
}
