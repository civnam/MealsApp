//
//  CategoryMealCell.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import UIKit

class CategoryMealCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    private let imageUrl = "https://www.themealdb.com/images/category/"
    
    private var mealNameButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .customWhite1
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .none
        imageView.layer.cornerRadius = 10
        
        return imageView
    }()
    
    private var customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()

    func setMeal(meal: MealsCategory) {
        
        setupViews()
        setupConstraints()
        
        self.mealNameButton.setTitle(meal.categoryName, for: .normal)
        let url = imageUrl + meal.categoryName + ".png"
        self.mealImageView.loadImage(urlStr: url)
    }

    private func setupViews() {
        
        contentView.addSubview(customBackgroundView)
        customBackgroundView.addSubview(mealImageView)
        customBackgroundView.addSubview(mealNameButton)
    }
    
    private func setupConstraints() {
        
        self.contentView.backgroundColor = .customYellow2
        self.contentView.layer.cornerRadius = 10
        
        customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        mealImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        mealImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        mealImageView.centerXAnchor.constraint(equalTo: customBackgroundView.centerXAnchor).isActive = true
        mealImageView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 8).isActive = true
        
        mealNameButton.topAnchor.constraint(equalTo: mealImageView.bottomAnchor, constant: 5).isActive = true
        mealNameButton.centerXAnchor.constraint(equalTo: mealImageView.centerXAnchor).isActive = true
        mealNameButton.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 0).isActive = true
        mealNameButton.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: 0).isActive = true
        mealNameButton.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor, constant: 0).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
