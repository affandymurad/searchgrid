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
    
    @objc func pressed() {
        let vc = SaringViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
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
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        let statusBarHeight = Swift.min(statusBarSize.width, statusBarSize.height)
        let btn = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 30.0 - statusBarHeight, width: UIScreen.main.bounds.width, height: 50))
        btn.backgroundColor = .clover
        btn.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        btn.setTitle("Filter", for: .normal)
        return btn
    }()
    
    let refreshControl = UIRefreshControl()
    
    private let viewModel = ReactiveSearchListViewModel()
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start = 0
        viewModel.rows = 10
        
        self.setupView()
        self.setupViewModel()
        
    }

    
    private func setupView() {
        title = "Search"
        
        view.addSubview(collectionView)
        view.addSubview(applyButton)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)

        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.bottomAnchor.constraint(equalTo: applyButton.topAnchor),
            
            
            applyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            applyButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            applyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    
        view.backgroundColor = .white
        collectionView.refreshControl = refreshControl
    }
    
    private func setupViewModel(){
        
        
        let input = ReactiveSearchListViewModel.Input(didLoadTriger: .just(()), didTapCellTriger: collectionView.rx.itemSelected.asDriver(), pullToRefreshTrigger: refreshControl.rx.controlEvent(.allEvents).asDriver(), didScrollReachBottom: .just(()))
        
        let output = viewModel.transform(input: input)
        
        
        output.searchListCellData.drive(collectionView.rx.items(cellIdentifier: SearchCollectionViewCell.reuseIdentifier, cellType: SearchCollectionViewCell.self)){
            row, model, cell in cell.configureCell(with: model)
        }.disposed(by: disposeBag)
        
        output.errorData.drive(onNext: {errorMessage in print ("error nih", errorMessage)}).disposed(by: disposeBag)
        
//        output.selectedIndex.drive(onNext: {(index, model) in print("inih index \(index), model: \(model)")}).disposed(by: disposeBag)
        
        output.isLoading.drive(refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y == scrollView.frame.size.height)       {
        // You have reached page 1
            scrollingFinished(scrollView: scrollView)
        }
    }
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if decelerate {
//            //didEndDecelerating will be called for sure
//            print("decelerate")
//            return
//        }
//        else {
//            scrollingFinished(scrollView: scrollView)
////            scrollingFinished(scrollView: scrollView)
//        }
//    }
    
    
    
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//    if scrollView == collectionView {
//        print("collectionview")
//      if (scrollView.bounds.maxY) == scrollView.contentSize.height{
//           scrollingFinished(scrollView: scrollView)
    

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
        // then we are at the top
        print("awal")
    }
    else if isAtBottom
    {
        // then we are at the end
//        print("terakhir")
        viewModel.start = 0
        viewModel.rows = 10
        
        setupViewModel()
        
    }
//        }
//    }
  }
    
    func scrollingFinished(scrollView: UIScrollView) {
       // Your code
        print("terakhir")
    }
}


