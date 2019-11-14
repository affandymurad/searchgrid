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
import WARangeSlider


class SaringViewController: UIViewController {
    let min = 0.0
    let max = 100000000.0
    
    let rangeSliders : RangeSlider = {
        let rangeSlider = RangeSlider(frame: CGRect.zero)
        rangeSlider.trackTintColor = .lightGray
        rangeSlider.trackHighlightTintColor = .clover
        rangeSlider.thumbTintColor = .white
        rangeSlider.thumbBorderColor = .clover
        rangeSlider.thumbBorderWidth = 2.0
        rangeSlider.lowerValue = 0.0
        rangeSlider.upperValue = 10000000.0
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        return rangeSlider
    }()
     

    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stackViewMinimumMaximum, rangeSliders])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
        
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSliders.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 100,
        width: width, height: 31.0)

        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
        
//        stackView.addArrangedSubview(nameLabel)
//        stackView.addArrangedSubview(searchTextInput)
        
//        stackView.addArrangedSubview(buttonSearch)
//        stackView.addArrangedSubview(ageLabel)
//        stackView.addArrangedSubview(positionLabel)

//        let margin: CGFloat = 20.0
//        let width = view.bounds.width - 2.0 * margin
//        rangeSliders.frame = CGRect(x: margin, y: margin,
//                                    width: 100.0, height: 40.0)
        
        stackViewMinimum.addArrangedSubview(minimumLabel)
        stackViewMinimum.addArrangedSubview(minimumTextInput)
        stackViewMaximum.addArrangedSubview(maximumLabel)
        stackViewMaximum.addArrangedSubview(maximumTextInput)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMinimum)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMaximum)
        stackView.addArrangedSubview(stackViewMinimumMaximum)
//        stackView.addArrangedSubview(rangeSliders)
        
        self.view.addSubview(stackView)
        self.view.addSubview(rangeSliders)
        
        buttonSearch.setTitle("Search", for: .normal)
        buttonSearch.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        
//        rangeSliders.translatesAutoresizingMaskIntoConstraints = false
//        rangeSliders.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
//        rangeSliders.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        rangeSliders.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    }

    @objc func close(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func reset(){
//        resetState()
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        minimumTextInput.text = formatter.string(from: NSNumber(value: Int((rangeSlider.lowerValue * 2000).rounded() * 5000)))
        
        maximumTextInput.text = formatter.string(from: NSNumber(value: Int((rangeSlider.upperValue * 2000).rounded() * 5000)))
    }

}


