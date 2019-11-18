//
//  TokoViewController.swift
//  search
//
//  Created by Affandy Murad on 16/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TokoViewController: UIViewController {
    
    var isGoldChecked = false
    var isOfficialChecked = false
    
    @objc func buttonGoldClicked(sender: UIButton) {
        isGoldChecked = !isGoldChecked
        print("Gold \(isGoldChecked)")

        if isGoldChecked {
            sender.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for:.normal)
        }
        
    }
    
    @objc func buttonOfficialClicked(sender: UIButton) {

        isOfficialChecked = !isOfficialChecked
        print("Official \(isOfficialChecked)")

        if isOfficialChecked {
            sender.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for:.normal)
        }
        
    }
    
    
    private let tokoButton : UIButton =  {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30.0 - statusBarHeight, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.setTitle("Apply", for: .normal)
        
        return btn
    }()
    
    @objc func pressed() {
         UserDefaults.standard.set(isOfficialChecked, forKey: "official")
         UserDefaults.standard.set(isGoldChecked, forKey: "fshop")
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var stackViewToko: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var goldLabel: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(buttonGoldClicked(sender:)), for: .touchUpInside)
        btn.setTitle("Gold Merchant", for: .normal)
        return btn
    }()
    
    private lazy var officialLabel: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(buttonOfficialClicked(sender:)), for: .touchUpInside)
        btn.setTitle("Official Store", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        initialValue()
    }
    
    func setupView() {
        title = "Shop Type"
        
        view.backgroundColor = UIColor.white
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
        
        stackViewToko.addArrangedSubview(goldLabel)
        stackViewToko.addArrangedSubview(officialLabel)
        self.view.addSubview(stackViewToko)
        self.view.addSubview(tokoButton)
        
        stackViewToko.translatesAutoresizingMaskIntoConstraints = false
        stackViewToko.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackViewToko.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewToko.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackViewToko.bottomAnchor.constraint(equalTo: self.stackViewToko.topAnchor).isActive = true
        stackViewToko.isLayoutMarginsRelativeArrangement = true
        

        tokoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tokoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        tokoButton.topAnchor.constraint(equalTo: stackViewToko.bottomAnchor).isActive = true
        tokoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
        @objc func close(){
            navigationController?.popViewController(animated: true)
        }
        
        @objc func reset(){
            self.isOfficialChecked = false
            goldLabel.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
            self.isGoldChecked = false
            officialLabel.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
        }
    
    
    func initialValue() {
        self.isOfficialChecked = UserDefaults.standard.bool(forKey: "official")
        self.isGoldChecked = UserDefaults.standard.bool(forKey: "fshop")
         
        if isOfficialChecked {
            officialLabel.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
        } else {
            officialLabel.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for:.normal)
        }
        
        if isGoldChecked {
            goldLabel.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
        } else {
            goldLabel.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for:.normal)
        }
    }
}
