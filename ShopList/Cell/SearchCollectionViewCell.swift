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
    private let profileImageView = UIImageView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 32
        profileImageView.backgroundColor = .lightGray
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
//            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 64),
            profileImageView.widthAnchor.constraint(equalToConstant: 64),
            profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
//            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 8),
            
//            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 16),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
        
    }
    
    func configureCell(with data: SearchListCellData) {
        profileImageView.kf.setImage(with: URL(string: data.imageURL))
        nameLabel.text = data.name
        priceLabel.text = data.price
    }
    
}
