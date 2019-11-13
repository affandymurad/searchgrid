//
//  SearchCollectionViewCell.swift
//  search
//
//  Created by Affandy Murad on 13/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import UIKit
import Kingfisher

struct SearchListCellData {
    let imageURL: String
    let name: String
    let price: String
}

class SearchCollectionViewCell: UICollectionViewCell {
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.backgroundColor = UIColor.gray
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray.withAlphaComponent(0.7)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor.maraschino.withAlphaComponent(0.7)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView : UIStackView = {
        let stack = UIStackView()
        stack.axis  = NSLayoutConstraint.Axis.vertical
        stack.distribution  = UIStackView.Distribution.equalSpacing
        stack.alignment = UIStackView.Alignment.center
        stack.spacing   = 8.0
        return stack
    }()
    
    

    
    
    static let reuseIdentifier = "SearchCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
//        let numberOfItemsPerRow: CGFloat = 2.0
//        let screenSize: CGRect = UIScreen.main.bounds
//        let leftAndRightPaddings: CGFloat = 50.0
//
//        let width = (screenSize.width)/numberOfItemsPerRow
//        let height = (screenSize.height)/numberOfItemsPerRow
        
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(stackView)
        
//        contentView.addSubview(profileImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            profileImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width - 10),
//            profileImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
            
            
//            profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
//            profileImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
//            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
//
//            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
//            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
//            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            nameLabel.heightAnchor.constraint(equalToConstant: 15),
//            nameLabel.widthAnchor.constraint(equalToConstant: 10),
//            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
//
//            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
//            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5),
//            priceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            priceLabel.heightAnchor.constraint(equalToConstant: 15),
//            priceLabel.widthAnchor.constraint(equalToConstant: 10),
//            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
//            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
            
        ])
        
    }
    
    func configureCell(with data: SearchListCellData) {
        profileImageView.kf.setImage(with: URL(string: data.imageURL))
        nameLabel.text = data.name
        priceLabel.text = data.price
    }
    
}
