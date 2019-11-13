//
//  ViewController.swift
//  search
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import RxSwift
import UIKit
import RxCocoa

class ViewController: UIViewController {

//    private let tableView: UITableView = {
//        let tv = UITableView(frame: .zero, style: .plain)
//        tv.register(SearchListTableViewCell.self, forCellReuseIdentifier: SearchListTableViewCell.reuseIdentifier)
//        tv.estimatedRowHeight = 80
//        tv.rowHeight = 80
//        tv.translatesAutoresizingMaskIntoConstraints = false
//        return tv
//    }()
    
    
    private let collectionView: UICollectionView = {
        let numberOfItemsPerRow: CGFloat = 2.0
        let screenSize: CGRect = UIScreen.main.bounds
    
        let layout = UICollectionViewFlowLayout()
        let width = (screenSize.width) / numberOfItemsPerRow
        let height = (screenSize.height) / 3.0
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        return cv
    }()
    
    private let applyButton : UIButton =  {
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 50.0, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.setTitle("Filter", for: .normal)
        return btn
    }()
    
    let refreshControl = UIRefreshControl()
    
    private let viewModel = ReactiveSearchListViewModel()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupViewModel()
        // Do any additional setup after loading the view.
//        NetworkManager.sharedInstance.rx.request(.cari(params: .specify(q: "Samsung", pmin: "10000", pmax: "1000000", wholesale: "true", official: "true", fshop: "2", start: "0", rows: "10")))
//            .asObservable()
//            .subscribe{ (shop) in
//                switch shop {
//                case .next(let response):
//                    let shop = try! JSONDecoder().decode(ShopResponse.self, from: response.data)
////                    print("PAIN")
//                    print(shop.data)
//                case .error(let error):
//                    print(error)
//                case .completed:
//                    print("data")
//                }
//        }.disposed(by: disposeBag)
        
    

    }
    
    private func setupView() {
        title = "Search"
        view.addSubview(collectionView)
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            
            applyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            applyButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            applyButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            applyButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    
        view.backgroundColor = .white
        collectionView.refreshControl = refreshControl
    }
    
    private func setupViewModel(){
        let input = ReactiveSearchListViewModel.Input(didLoadTriger: .just(()), didTapCellTriger: collectionView.rx.itemSelected.asDriver(), pullToRefreshTrigger: refreshControl.rx.controlEvent(.allEvents).asDriver())
        
        let output = viewModel.transform(input: input)
        
        
        output.searchListCellData.drive(collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.reuseIdentifier, cellType: SearchCollectionViewCell.self)){
            row, model, cell in cell.configureCell(with: model)
        }.disposed(by: disposeBag)
        
        output.errorData.drive(onNext: {errorMessage in print ("error nih", errorMessage)}).disposed(by: disposeBag)
        
        output.selectedIndex.drive(onNext: {(index, model) in print("inih index \(index), model: \(model)")}).disposed(by: disposeBag)
        
        output.isLoading.drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        
    }

    

}

