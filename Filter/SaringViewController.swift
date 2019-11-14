//
//  SaringViewController.swift
//  search
//
//  Created by Affandy Murad on 14/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class SaringViewController: UIViewController {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewMinimumMaximum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var stackViewMinimum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var minimumLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum Price"
        return label
    }()
    
    private let minimumTextInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Rp"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var stackViewMaximum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var maximumLabel: UILabel = {
        let label = UILabel()
        label.text = "Maximum Price"
        return label
    }()
    
    private let maximumTextInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Rp"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    
    private let buttonSearch = UIButton.init(type: .system)
    

    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age: -"
        return label
    }()
    
    private lazy var positionLabel: UILabel = {
        let label = UILabel()
        label.text = "Position: -"
        return label
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    

//        searchTextInput.rx.text
//            .subscribe(self.positionLabel.rx.text)
//            .disposed(by: disposeBag)
        
        buttonSearch.rx.tap.subscribe(onNext: {_ in print("tap action")}).disposed(by: disposeBag)
    }

    
    // MARK: Function setup view
     func setupView() {
        title = "Filter"
        
        view.backgroundColor = UIColor.white
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
        
//        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(searchTextInput)
        
//        stackView.addArrangedSubview(buttonSearch)
//        stackView.addArrangedSubview(ageLabel)
//        stackView.addArrangedSubview(positionLabel)
        
        stackViewMinimum.addArrangedSubview(minimumLabel)
        stackViewMinimum.addArrangedSubview(minimumTextInput)
        stackViewMaximum.addArrangedSubview(maximumLabel)
        stackViewMaximum.addArrangedSubview(maximumTextInput)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMinimum)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMaximum)
        stackView.addArrangedSubview(stackViewMinimumMaximum)
        self.view.addSubview(stackView)
        
        buttonSearch.setTitle("Search", for: .normal)
        buttonSearch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 10).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    }

    @objc func close(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func reset(){
//        resetState()
    }

}


