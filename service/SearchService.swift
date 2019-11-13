//
//  SearchService.swift
//  search
//
//  Created by Affandy Murad on 12/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchServiceError: Error {
    case missingData
}

protocol SearchServiceProtocol {
    func reactiveFetchSearchs() -> Observable<[Shop]>
}

class NetworkSearchService: SearchServiceProtocol {
    
    func reactiveFetchSearchs() -> Observable<[Shop]> {
        let response = NetworkManager.sharedInstance.rx.request(.cari(params: .specify(q: "Samsung", pmin: "10000", pmax: "1000000", wholesale: "true", official: "true", fshop: "2", start: "0", rows: "10")))
                    .asObservable()
                    .flatMap{ data -> Observable<ShopResponse> in
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        do{
                            let resultData = try decoder.decode(ShopResponse.self, from: data.data)
                            return Observable.just(resultData)
                        } catch (let decodeError) {
                            return Observable.error(decodeError)
                        }
                    }
        
        let search = response.map{ $0.data}
        return search
    }
    
    
}

