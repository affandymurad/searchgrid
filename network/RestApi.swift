//
//  RestApi.swift
//  search
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation
import Moya
import RxSwift


extension Route: TargetType {
    
    static func baseUrl() -> String {
        let baseUrl = "https://ace.tokopedia.com/search/v2.5"
        return baseUrl
    }
    
    var baseURL: URL {
        return URL(string: Route.baseUrl())!
    }
    
    var path: String {
        return url()
    }
    
    var method: Moya.Method {
        switch self {
        case .cari:
            return Moya.Method.get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var task: Task {
        guard let parameters = params else {
            return .requestPlain
        }
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }
    

    
    var headers: [String : String]? {
        return [:]
    }
    
    var params: [String:String]? {
        switch self {
        case .cari(let params):
            switch params {
            case .specify(let q, let pmin, let pmax, let wholesale, let official, let fshop, let start, let rows):
                return ["q": q,
                        "pmin": pmin,
                        "pmax": pmax,
                        "wholesale": wholesale,
                        "official": official,
                        "fshop": fshop,
                        "start": start,
                        "rows": rows
                        
                ]
            }
        }
    }
    
}
