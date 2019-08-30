//
//  FeedData.swift
//  MobileBuyer
//
//  Created by Nanthicha Kritveeranant on 27/8/2562 BE.
//  Copyright © 2562 Nanthicha Kritveeranant. All rights reserved.
//

import Alamofire
import Foundation

class FeedData {
  
  static var shared = FeedData() // Single ton
  var urlData = "https://scb-test-mobile.herokuapp.com/api/mobiles/"
  var urlPicture = "https://scb-test-mobile.herokuapp.com/api/mobiles/%@/images//"
  
  
  func feed(completion: @escaping ([MobileModel]) -> Void) {
    AF.request(URL(string: urlData)!, method: .get).responseJSON { response in
      //      print(response)
      switch response.result {
      case .success:
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode([MobileModel].self, from: response.data!)
          completion(result)
          //          print("success")
        } catch {
          //          print("catch")
        }
        break
      case let .failure(error):
        print(error)
        break
      }
    }
  }
  
  func getPicture(id: String, completion: @escaping ([PictureModel]) -> Void) {
    
    AF.request(URL(string: String(format: urlPicture, id))!, method: .get).responseJSON { response in
//      print(response)
      switch response.result {
      case .success:
        do {
          let decoder = JSONDecoder()
          let result = try decoder.decode([PictureModel].self, from: response.data!)
          completion(result)
//          print("success feed")
//          print("sucess api \(response.description)")
        } catch let error {
          print("error case success")
          print(error)
        }
        break
      case let .failure(error):
        print("error case failure")
        print(error)
        break
      }
    }
  }
}

