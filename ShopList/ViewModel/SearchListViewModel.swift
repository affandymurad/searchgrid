//
//  SearchCollectionViewModel.swift
//  search
//
//  Created by Affandy Murad on 13/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation
import UIKit

class SearchListViewModel: NSObject {
    private let service: SearchServiceProtocol
    private var searchCellData: [SearchListCellData] = []
    private var rawSearchs: [Shop] = []

    // Mark: - View Model Outputs
    var onSearchSelectedByID: ((Int) -> Void)?
    var onDataRefreshed: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(service: SearchServiceProtocol = NetworkSearchService()){
        self.service = service
        super.init()
    }
    
    func fetchSearchList() {
        service.reactiveFetchSearchs().subscribe{
            (shop) in
            switch shop {
            case .next(let response):
                self.rawSearchs = response
            case .error(let error):
                self.onError = (error as! ((Error) -> Void))
            case .completed:
                self.searchCellData = self.rawSearchs.map {
                    SearchListCellData(imageURL: $0.imageUri!, name: $0.name!, price: $0.price!)
                }
            }
        }
    }
    
    
}

// MARK: - Table view data source & delegates will be implemented here
extension SearchListViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchCellData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellData = searchCellData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as! SearchCollectionViewCell
        cell.configureCell(with: cellData)
        return cell
    }
    
}
