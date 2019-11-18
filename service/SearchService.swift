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
    func reactiveFetchSearchs(start: String, rows: String) -> Observable<[Shop]>
}

class NetworkSearchService: SearchServiceProtocol {
    
    let q_v = UserDefaults.standard.string(forKey: "q") ?? "Samsung"
    let pmin_v = UserDefaults.standard.string(forKey: "pmin") ?? "0"
    let pmax_v = UserDefaults.standard.string(forKey: "pmax") ?? "10000000"
    let wholesale_v = UserDefaults.standard.bool(forKey: "wholesale")
    let official_v = UserDefaults.standard.bool(forKey: "official")
    let fshop_v = UserDefaults.standard.bool(forKey: "fshop")
    
    
    func reactiveFetchSearchs(start: String, rows: String) -> Observable<[Shop]> {
        let response = NetworkManager.sharedInstance.rx.request(.cari(params: .specify(q: q_v, pmin: pmin_v, pmax: pmax_v, wholesale:String(wholesale_v), official: String(official_v), fshop: String(fshop_v), start: start, rows: rows)))
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

