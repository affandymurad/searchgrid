//
//  ShowResponse.swift
//  search
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation

struct ShopResponse: Codable {
    let status: StatusModel?
    let data: [Shop]
}

