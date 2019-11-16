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
    
    private let saringButton : UIButton =  {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30.0 - statusBarHeight, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.setTitle("Apply", for: .normal)
        return btn
    }()
    
    @objc func pressed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
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
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var minimumLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum Price"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let minimumTextInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var stackViewMaximum: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var maximumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.text = "Maximum Price"
        return label
    }()
    
    private let maximumTextInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "10.0000.000"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
        private lazy var stackViewSwitch: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 100, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Whole Sale"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let switchDemo : UISwitch = {
    let sw = UISwitch(frame:CGRect(x: 150, y: 300, width: 0, height: 0))
    sw.isOn = true
    sw.setOn(true, animated: true)
    sw.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
    return sw
    }()
    
    private lazy var stackViewSearch: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private let searchTextInput: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Samsung"
        textField.autocorrectionType = .no
        textField.font = .systemFont(ofSize: 18)
        textField.textColor = UIColor.darkGray
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        return textField
    }()
    
    private lazy var stackViewCloud: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var cloudLabel: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 50))
        btn.backgroundColor = .white
        btn.setTitleColor(.black, for: .normal)
        btn.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(openToko), for: .touchUpInside)
        btn.setTitle("Shop Type", for: .normal)
        return btn
    }()
    
    
    
 
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    // MARK: Function setup view
     func setupView() {
        title = "Filter"
        
        view.backgroundColor = UIColor.white
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem

        let numberOfItemsPerRow: CGFloat = 2.0
        let screenSize: CGRect = UIScreen.main.bounds
        let widthmin = (screenSize.width) / numberOfItemsPerRow
        
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSliders.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 150,
        width: width, height: 31.0)
        
        let disclosure = UITableViewCell()
        disclosure.frame = cloudLabel.bounds
        disclosure.accessoryType = .disclosureIndicator
        disclosure.isUserInteractionEnabled = false
        cloudLabel.addSubview(disclosure)
        
        stackViewSearch.addArrangedSubview(searchLabel)
        stackViewSearch.addArrangedSubview(searchTextInput)
        
        stackViewCloud.addArrangedSubview(cloudLabel)
        
        stackViewSwitch.addArrangedSubview(switchLabel)
        stackViewSwitch.addArrangedSubview(switchDemo)
        
        stackViewMinimum.addArrangedSubview(minimumLabel)
        stackViewMinimum.addArrangedSubview(minimumTextInput)
        stackViewMinimum.widthAnchor.constraint(equalToConstant: widthmin).isActive = true
        stackViewMaximum.addArrangedSubview(maximumLabel)
        stackViewMaximum.addArrangedSubview(maximumTextInput)
        
        stackViewMaximum.widthAnchor.constraint(equalToConstant: widthmin).isActive = true
        stackViewMinimumMaximum.addArrangedSubview(stackViewMinimum)
        stackViewMinimumMaximum.addArrangedSubview(stackViewMaximum)
        stackView.addArrangedSubview(stackViewMinimumMaximum)
        

        self.view.addSubview(stackView)
        self.view.addSubview(stackViewSwitch)
        self.view.addSubview(rangeSliders)
        self.view.addSubview(stackViewSearch)
        self.view.addSubview(stackViewCloud)
        self.view.addSubview(saringButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: stackViewSwitch.topAnchor).isActive = true
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackViewSwitch.translatesAutoresizingMaskIntoConstraints = false
        stackViewSwitch.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
        stackViewSwitch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        stackViewSwitch.bottomAnchor.constraint(equalTo: stackViewSearch.topAnchor).isActive = true
        stackViewSwitch.isLayoutMarginsRelativeArrangement = true
        
        stackViewSearch.translatesAutoresizingMaskIntoConstraints = false
        stackViewSearch.topAnchor.constraint(equalTo: stackViewSwitch.bottomAnchor).isActive = true
        stackViewSearch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewSearch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackViewSwitch.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackViewSearch.isLayoutMarginsRelativeArrangement = true
        
        stackViewCloud.translatesAutoresizingMaskIntoConstraints = false
        stackViewCloud.topAnchor.constraint(equalTo: stackViewSearch.bottomAnchor).isActive = true
        stackViewCloud.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stackViewCloud.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        stackViewSwitch.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        stackViewCloud.isLayoutMarginsRelativeArrangement = true
        

        saringButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        saringButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        saringButton.topAnchor.constraint(equalTo: stackViewSwitch.bottomAnchor).isActive = true
        saringButton.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    @objc func close(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func openToko(){
        let vc = TokoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func reset(){
//        resetState()
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn == true){
            print("on")
        }
        else{
            print("off")
        }
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        let formatter = NumberFormatter()
//        formatter.numberStyle = .none
//        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        minimumTextInput.text = formatter.string(from: NSNumber(value: Int((rangeSlider.lowerValue * 2000).rounded() * 5000)))
        
        maximumTextInput.text = formatter.string(from: NSNumber(value: Int((rangeSlider.upperValue * 2000).rounded() * 5000)))
    }

}


