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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        title = "Filter"
        
        view.backgroundColor = UIColor.white
        
//        let slider = UISlider()
//        slider.frame = CGRect(x: 0, y: 0, width: 250, height: 35)
//        slider.center = self.view.center
//
//
//        slider.minimumTrackTintColor = .clover
//        slider.maximumTrackTintColor = .lightGray
//        slider.thumbTintColor = .white
//
//        slider.maximumValue = 100
//        slider.minimumValue = 0
//        slider.setValue(50, animated: false)
//
//        slider.addTarget(self, action: #selector(changeVlaue(_:)), for: .valueChanged)
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
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
        
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
