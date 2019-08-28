//
//  PictureModel.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 28/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Foundation

struct PictureElement: Codable {
  let mobileID,id: Int
  let url: String

  enum CodingKeys: String, CodingKey {
    case mobileID = "mobile_id"
    case url, id
  }
}

typealias Picture = [PictureElement]
