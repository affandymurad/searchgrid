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
    
    let viewModel = ReactiveSearchListViewModel()

    let disposeBag = DisposeBag()
    
   let didScrollReachBottomTrigger = PublishSubject<Void>()
        
    @objc func pressed() {
        let vc = SaringViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchNew() {
        viewModel.start = 0
        let a = NetworkSearchService().reactiveFetchSearchs(start: String(self.viewModel.start), rows: String(self.viewModel.start))
                
        a.subscribe().disposed(by: disposeBag)
        let nav1 = UINavigationController()
        let mainView = ViewController() //ViewController = Name of your controller
        nav1.viewControllers = [mainView]
        UIApplication.shared.keyWindow?.rootViewController = nav1
            
    }
    

    func reloadMore() {

        viewModel.start += 10
        let a = NetworkSearchService().reactiveFetchSearchs(start: String(self.viewModel.start), rows: String(self.viewModel.start))
        self.didScrollReachBottomTrigger.onNext(a.subscribe(onNext: {result in
            print("jumlah \(self.viewModel.privateDataSource.value.count)")
        }).disposed(by: disposeBag))
    }
    
    private let collectionView: UICollectionView = {
        let numberOfItemsPerRow: CGFloat = 2.0
        let screenSize: CGRect = UIScreen.main.bounds
    
        let layout = UICollectionViewFlowLayout()
        let width = (screenSize.width) / numberOfItemsPerRow
        let height = (screenSize.height) / numberOfItemsPerRow
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isScrollEnabled = true
        return cv
    }()
    
    private let applyButton : UIButton =  {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30.0 - statusBarHeight, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.setTitle("Filter", for: .normal)
        return btn
    }()
    
    let refreshControl = UIRefreshControl()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.setupViewModel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(searchNew), name: NSNotification.Name(rawValue: "load"), object: nil)
    }

    
    private func setupView() {
        title = "Search"
        
        view.addSubview(collectionView)
        view.addSubview(applyButton)
    
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            applyButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    
        view.backgroundColor = .white
        collectionView.refreshControl = refreshControl
    }
    
    func setupViewModel(){
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
        
        let input = ReactiveSearchListViewModel.Input(didLoadTriger:.just(()), didTapCellTriger:  collectionView.rx.itemSelected.asDriver(), pullToRefreshTrigger: refreshControl.rx.controlEvent(.allEvents).asDriver(), didScrollReachBottom:didScrollReachBottomTrigger.asObserver().asDriver(onErrorJustReturn: ()))

    
        let output = viewModel.transform(input: input)
        
        output.searchListCellData.drive(collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.reuseIdentifier, cellType: SearchCollectionViewCell.self)){
           row, element, cell in
            cell.configureCell(with: element)
        }.disposed(by: disposeBag)
    
        
        output.errorData.drive(onNext: {errorMessage in
            let alert = UIAlertController(title: "Ups", message: "Error: \(errorMessage)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)}).disposed(by: disposeBag)
    
        output.isLoading.drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        
    }
    


}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            var verticalOffsetForTop: CGFloat {
            let topInset = scrollView.contentInset.top
            return -topInset
        }

        var verticalOffsetForBottom: CGFloat {
            let scrollViewHeight = scrollView.bounds.height
            let scrollContentSizeHeight = scrollView.contentSize.height
            let bottomInset = scrollView.contentInset.bottom
            let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
            return scrollViewBottomOffset
        }
        
        var isAtTop: Bool {
            return scrollView.contentOffset.y <= verticalOffsetForTop
        }

        var isAtBottom: Bool {
            return scrollView.contentOffset.y >= verticalOffsetForBottom
        }

        if isAtTop
        {
           viewModel.start = 0
            print("awal")
        }
        else if isAtBottom
        {
            // then we are at the end
            print("terakhir")
            reloadMore()
        
        }
        
    }
    
}


