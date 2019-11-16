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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        title = "Shop Type"
        
        view.backgroundColor = UIColor.white
        
        let closeBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem  = closeBarButtonItem
        
        let resetBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(reset))
        self.navigationItem.rightBarButtonItem  = resetBarButtonItem
    }
    
        @objc func close(){
            navigationController?.popViewController(animated: true)
        }
        
        @objc func reset(){
    //        resetState()
        }
}
