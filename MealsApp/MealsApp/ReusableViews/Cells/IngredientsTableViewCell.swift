//
//  IngredientsTableViewCell.swift
//  MealsApp
//
//  Created by Isaac Dimas on 01/10/23.
//

import UIKit

class IngredientsCell: UITableViewCell {
    
    static let identifier = "IngredientsCell"
    
    private var ingredientLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private var measureLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupContentViewConfig()
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setIngredient(ingredient: String, measure: String) {
        
        ingredientLbl.text = ingredient
        measureLbl.text = "|  " + measure
    }
    
    private func setupContentViewConfig() {
        
        contentView.backgroundColor = .customYellow2
    }

    private func setupViews() {
        
        contentView.addSubview(customBackgroundView)
        customBackgroundView.addSubview(ingredientLbl)
        customBackgroundView.addSubview(measureLbl)
    }
    
    private func setupConstraints() {
        
        customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        ingredientLbl.heightAnchor.constraint(equalToConstant: 70).isActive = true
        ingredientLbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        ingredientLbl.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor, constant: 16).isActive = true
        ingredientLbl.centerYAnchor.constraint(equalTo: customBackgroundView.centerYAnchor, constant: 0).isActive = true
        
        measureLbl.centerYAnchor.constraint(equalTo: ingredientLbl.centerYAnchor, constant: 0).isActive = true
        measureLbl.heightAnchor.constraint(equalToConstant: 50).isActive = true
        measureLbl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        measureLbl.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor, constant: -32).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

