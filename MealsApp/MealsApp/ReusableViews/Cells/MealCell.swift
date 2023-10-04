//
//  MealCell.swift
//  MealsApp
//
//  Created by Isaac Dimas on 30/09/23.
//

import UIKit

class MealCell: UITableViewCell {
    
    static let identifier = "MealCell"
    
    private var mealNameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var mealImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "house")
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .none
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private var customBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite1
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setMeal(meal: Meal) {
        
        self.mealNameLbl.text = meal.strMeal ?? ""
        self.mealImageView.loadImage(urlStr: meal.strMealThumb ?? "")
    }

    private func setupViews() {
        
        contentView.addSubview(customBackgroundView)
        customBackgroundView.addSubview(mealImageView)
        customBackgroundView.addSubview(mealNameLbl)
    }
    
    private func setupConstraints() {
        
        self.contentView.backgroundColor = .customYellow2
        
        customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true

        mealImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        mealImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        mealImageView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 16).isActive = true
        mealImageView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor, constant: 8).isActive = true
        
        mealNameLbl.centerYAnchor.constraint(equalTo: mealImageView.centerYAnchor, constant: 0).isActive = true
        mealNameLbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
        mealNameLbl.widthAnchor.constraint(equalToConstant: contentView.bounds.width / 1.7).isActive = true
        mealNameLbl.leadingAnchor.constraint(equalTo: mealImageView.trailingAnchor, constant: 16).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
