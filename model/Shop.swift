//
//  Shop.swift
//  search
//
//  Created by Affandy Murad on 10/11/19.
//  Copyright © 2019 Affandy Murad. All rights reserved.
//

import Foundation

struct Shop : Codable{
    
    let id: Int?
    let name: String?
    let uri: String?
    let imageUri: String?
    let imageUriLarge: String?
    let price: String?
    let priceRange: String?
    let categoryBreadcrumb: String?
    
    enum ShopCodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case uri = "uri"
        case imageUri = "image_uri"
        case imageUriLarge = "image_uri_700"
        case price = "price"
        case priceRange = "price_range"
        case categoryBreadcrumb = "category_breadcrumb"
    }
}

