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
//    var rawSearchs: [Shop] = []

    // Mark: - View Model Outputs
//    var onSearchSelectedByID: ((Int) -> Void)?
    var onDataRefreshed: (() -> Void)?
    var onError: ((Error) -> Void)?
    
    init(service: SearchServiceProtocol = NetworkSearchService()){
        self.service = service
        super.init()
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
