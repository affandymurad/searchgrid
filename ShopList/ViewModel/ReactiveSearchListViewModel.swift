//
//  ReactiveSearchListViewModel.swift
//  search
//
//  Created by Affandy Murad on 12/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ReactiveSearchListViewModel: ViewModelType {
    let service: SearchServiceProtocol
    var start = 0
    var rows = 0
    
    init(service: SearchServiceProtocol = NetworkSearchService()) {
        self.service = service
    }
    
    struct Input {
        let didLoadTriger: Driver<Void>
        let didTapCellTriger: Driver<IndexPath>
        let pullToRefreshTrigger: Driver<Void>
        let didScrollReachBottom: Driver<Void>
    }
    
    struct Output {
        let searchListCellData: Driver<[SearchListCellData]>
        let errorData: Driver<String>
        let selectedIndex: Driver<(index: IndexPath, model: SearchListCellData)>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let errorMessage = PublishSubject<String>()
        let isLoading = BehaviorRelay<Bool>(value: false)
        
        let fetchDataTrigger = Driver.merge(input.didLoadTriger, input.pullToRefreshTrigger)
        
        
        
        let fetchData = fetchDataTrigger.do(onNext:{
            _ in isLoading.accept(true)
            })
            .flatMapLatest{
            [service] _ -> Driver<[Shop]> in service
                .reactiveFetchSearchs(start: String(self.start), rows: String(self.rows))
                .do(onNext:{_ in isLoading.accept(false)
                }, onError: {error in errorMessage.onNext(error.localizedDescription)
                    isLoading.accept(false)
                })
            .asDriver{_ -> Driver<[Shop]> in Driver.empty()}
        }
        
        let searchListCellData = fetchData.map{
            searchs -> [SearchListCellData] in searchs.map{
                search -> SearchListCellData in SearchListCellData(imageURL: search.imageUri!, name: search.name!, price: search.price!)
            }
        }
        
        let errorMessageDriver = errorMessage.asDriver(onErrorJustReturn: "").filter{$0.isEmpty}
        
        let selectedIndexCell = input.didTapCellTriger.withLatestFrom(searchListCellData) {index, searchs -> (index: IndexPath, model: SearchListCellData) in return (index: index, model: searchs[index.row])
        }
        
        return Output(searchListCellData: searchListCellData, errorData: errorMessageDriver, selectedIndex: selectedIndexCell, isLoading: isLoading.asDriver())
    }
    
    
    
}
