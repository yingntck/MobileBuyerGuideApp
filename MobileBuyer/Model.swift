//
//  Model.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Foundation

struct MobileElement: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name, mobileDescription: String
    
    enum CodingKeys: String, CodingKey {
        case rating, id, thumbImageURL, price, brand, name
        case mobileDescription = "description"
    }
}

typealias Mobile = [MobileElement]
