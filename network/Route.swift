//
//  Route.swift
//  search
//
//  Created by Affandy Murad on 11/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation

protocol RouteTrait {
    func url() -> String
}


enum Route {
    case cari(params: CariParams)
}

extension Route: RouteTrait {
    func url() -> String {
        switch self {
        case .cari:
            return "/product"
        }
    }
}

enum CariParams {
case specify(q: String, pmin: String, pmax: String, wholesale: String, official: String, fshop: String, start: String, rows: String)
}
