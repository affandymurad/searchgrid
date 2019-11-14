//
//  FilterViewController.swift
//  search
//
//  Created by Affandy Murad on 13/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import WARangeSlider

class FilterViewController: UIViewController {
    let rangeSlider = RangeSlider(frame: CGRect.zero)
    let min = 0.0
    let max = 10000000.0
    
    private let minimumLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20.0, y: 30.0, width: 100.0, height: 30.0))
        label.font = .systemFont(ofSize: 15)
        label.textColor = UIColor.darkGray.withAlphaComponent(0.7)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minimumText : UITextField = {
        let teks = UITextField(frame: CGRect(x: 20.0, y: 30.0, width: 100.0, height: 30.0))
        teks.placeholder = "Enter text here"
        teks.font = UIFont.systemFont(ofSize: 15)
        teks.setContentHuggingPriority(UILayoutPriority(249), for: .vertical)
        teks.autocorrectionType = UITextAutocorrectionType.no
        teks.clearButtonMode = UITextField.ViewMode.whileEditing
        teks.translatesAutoresizingMaskIntoConstraints = false
        return teks
    }()
    
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        title = "Filter"
        
        view.backgroundColor = UIColor.white
        
        
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        rangeSlider.frame = CGRect(x: margin, y: margin + topLayoutGuide.length + 100,
        width: width, height: 31.0)
        rangeSlider.maximumValue = max
        rangeSlider.minimumValue = min
        rangeSlider.trackTintColor = .lightGray
        rangeSlider.trackHighlightTintColor = .clover
        rangeSlider.thumbTintColor = .white
        rangeSlider.thumbBorderColor = .clover
        rangeSlider.thumbBorderWidth = 2.0
        rangeSlider.addTarget(self, action: #selector(rangeSliderValueChanged(_:)), for: .valueChanged)
        resetState()
        self.view.addSubview(rangeSlider)
//        stackView.addArrangedSubview(rangeSlider)
//        stackView.addArrangedSubview(rangeSlider)
//        stackView.addArrangedSubview(rangeSlider)
        self.view.addSubview(minimumText)
        
    
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
        
//        NSLayoutConstraint.activate([
//
//            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
//            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//
//        ])
        
    }
    
    func resetState() {
        rangeSlider.lowerValue = min
        rangeSlider.upperValue = max
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        print("Range slider value changed: (\(Int(rangeSlider.lowerValue)) , \(Int(rangeSlider.upperValue)))")
    }
    
    @objc func close(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func reset(){
        resetState()
    }
}
