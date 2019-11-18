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
    var rows = 10
//    var isStart = false
    
    
//    var rawSearchs: [Shop] = []
    let didScrollbottomTrigger = PublishSubject<Void>()
    

    let dataSource: Observable<[Shop]>
    let privateDataSource: Variable<[Shop]> = Variable([])
    
    init(service: SearchServiceProtocol = NetworkSearchService()) {
        self.service = service
        self.dataSource = privateDataSource.asObservable()
    }
    
    struct Input {
        let didLoadTriger: Driver<Void>
        let didTapCellTriger: Driver<IndexPath>
        let pullToRefreshTrigger: Driver<Void>
        let didScrollReachBottom: Driver<Void>
    }
    
    struct Output {
        let searchListCellData: Driver<[Shop]>
        let errorData: Driver<String>
        let selectedIndex: Driver<(index: IndexPath, model: Shop)>
        let isLoading: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let errorMessage = PublishSubject<String>()
        let isLoading = BehaviorRelay<Bool>(value: false)
        
        let fetchDataTrigger = Driver.merge(input.didLoadTriger, input.pullToRefreshTrigger, input.didScrollReachBottom)
        
        let fetchData = fetchDataTrigger.do(onNext:{
            _ in isLoading.accept(true)
            })
            .flatMap{
            [service] _ -> Driver<[Shop]> in
                service
                    .reactiveFetchSearchs(start: String(self.start), rows: String(self.rows))
                .do(onNext:{result in
                    isLoading.accept(false)
                if (self.start == 0) {
                    self.privateDataSource.value.removeAll()
                }
//                else {
                    self.privateDataSource.value.append(contentsOf: result)
//                }
                    
                }, onError: {error in errorMessage.onNext(error.localizedDescription)
                    isLoading.accept(false)
                })
                .asDriver{_ -> Driver<[Shop]> in Driver.empty()}
                    .map{_ in
                    return self.privateDataSource.value
                }
        }
        
        let errorMessageDriver = errorMessage.asDriver(onErrorJustReturn: "").filter{$0.isEmpty}
        
        let selectedIndexCell = input.didTapCellTriger.withLatestFrom(fetchData) {index, searchs -> (index: IndexPath, model: Shop) in return (index: index, model: searchs[index.row])
        }
        
        return Output(searchListCellData: fetchData, errorData: errorMessageDriver, selectedIndex: selectedIndexCell, isLoading: isLoading.asDriver())
    }
    
    
    
}
