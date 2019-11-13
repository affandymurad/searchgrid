//
//  StatusModel.swift
//  search
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation

struct StatusModel : Codable{
    let errorCode: Int?
    let message: String?
    
    enum StatusModelKeys: String, CodingKey {
        case errorCode = "error_code"
        case message = "message"
    }
}
