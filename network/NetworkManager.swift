//
//  NetworkManager.swift
//  search
//
//  Created by Affandy Murad on 11/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation
import Moya

class NetworkManager {
    static let sharedInstance = MoyaProvider<Route>(plugins: [NetworkLoggerPlugin(verbose: true)])
}
